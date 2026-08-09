#include "../utils/args.h"
#include "../utils/nixGet.h"
#include "../utils/split.h"
#include "../utils/systemHelper.h"
#include "../utils/ttyHelper.h"
#include <algorithm>
#include <cstddef>
#include <ctime>
#include <fcntl.h>
#include <filesystem>
#include <iostream>
#include <libtar.h>
#include <map>
#include <nlohmann/json.hpp>
#include <openssl/evp.h>
#include <pwd.h>
#include <stdexcept>
#include <string>
#include <unistd.h>
#include <vector>

using namespace std;

int main(int argc, char const *argv[]) {
  vector<string> args(argv, argv + argc);

  // list flags
  map<string, args::optionIn> argsAvailable = {
      {"strict", args::optionIn{"strict", 's'}},
      {"dynamic", args::optionIn{"dynamic", 'd'}},
      {"flake", args::optionIn{"flake", 'f', true, true}},
      {"key", args::optionIn{"key", 'k', true}},
      {"keySSH", args::optionIn{.longName = "keySSH", .takesValue = true}},
      {"keySigning",
       args::optionIn{.longName = "keySigning", .takesValue = true}},
  };

  // parse user input
  map<string, args::optionOut> argsProcessed;
  try {
    argsProcessed = args::parse(args, argsAvailable);
  } catch (invalid_argument e) {
    cerr << ttyHelper::error(e.what());
    return 1;
  }

  // rebuild mode
  if (argsProcessed["strict"].invoked == true &&
      argsProcessed["dynamic"].invoked == true) {
    cerr << ttyHelper::error("--dynamic (\033[35m-d\033[0m) and --strict "
                             "(\033[35m-s\033[0m) are mutually exclusive");
    return 1;
  }
  bool dynamicRebuild = true;
  if (argsProcessed["strict"].invoked == true) {
    dynamicRebuild = false;
  }

  // get flake
  string tmpPath = "/tmp/deploy";
  string flakeLink = *argsProcessed["flake"].value;
  string flakePath = tmpPath + "/nixosConfig";
  filesystem::create_directories(flakePath);
  if (filesystem::is_empty(flakePath) == false) {
    cerr << ttyHelper::warning("flakePath (\033[35m" + flakePath +
                               "\033[0m) is not empty. Deleting...");
    filesystem::remove_all(tmpPath);
  }
  systemHelper::result cmdOut = systemHelper::runCommand(
      "nix flake clone " + flakeLink + " --dest " + flakePath);
  if (cmdOut.exitCode != 0) {
    cerr << ttyHelper::error("failed to get flake (\033[35m" + flakeLink +
                             "\033[0m)");
    filesystem::remove_all(tmpPath);
    return 1;
  }

  // get available hosts
  vector<string> hosts;
  vector<string> availableHosts = nixGet::flakeHosts(flakePath);
  if (availableHosts.size() == 0) {
    cerr << ttyHelper::error("flake does not contain any hosts or no "
                             "hosts could be found");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  // compare against user input
  if (!argsProcessed["*"].value.has_value() ||
      argsProcessed["*"].value->size() == 0) {
    cerr << ttyHelper::error("no hosts selected. Please enter a host or type "
                             "'\033[35mman deploy\033[0m' for more info.");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  vector<string> userHosts =
      split::splitStrByChar(*argsProcessed["*"].value, ' ');
  if (userHosts.size() == 1 && userHosts[0] == "all") {
    hosts = availableHosts;
  } else {
    for (string userHost : userHosts) {
      if (ranges::contains(availableHosts, userHost)) {
        hosts.push_back(userHost);
      } else {
        cerr << ttyHelper::error("host (\033[35m" + userHost +
                                 "\033[0m) does not exist in flake");
        filesystem::remove_all(tmpPath);
        return 1;
      }
    }
  }
  if (hosts.size() == 0) {
    cerr << ttyHelper::error(
        "no hosts selected. This error should be able to be trigged");
    filesystem::remove_all(tmpPath);
    return 1;
  }

  // make manifest file
  string user;
  struct passwd *pw = getpwuid(getuid());
  if (!pw) {
    cerr << ttyHelper::error("couldn't find username");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  user = pw->pw_name;
  nlohmann::json manifestJson = {
      {"signingUser", user},
      {
          "signingTime",
          static_cast<int64_t>(time(nullptr)),
      },
      {"dynamic", dynamicRebuild},
      {"hosts", hosts},
  };
  systemHelper::saveFileFromStr(tmpPath + "/manifest.json",
                                nlohmann::to_string(manifestJson));

  // make flake path into tarball
  TAR *tarball = nullptr;
  if (tar_open(&tarball, (tmpPath + "/tarball.tar").c_str(), nullptr,
               O_WRONLY | O_CREAT, 0644, TAR_GNU) != 0) {
    cerr << ttyHelper::error("tar_open failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  if (tar_append_file(tarball, (tmpPath + "/manifest.json").c_str(),
                      "manifest.json") != 0) {
    cerr << ttyHelper::error("tar_append_file failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  if (tar_append_tree(tarball, const_cast<char *>(flakePath.c_str()),
                      const_cast<char *>("nixosConfig")) != 0) {
    cerr << ttyHelper::error("tar_append_tree failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  if (tar_append_eof(tarball) != 0) {
    cerr << ttyHelper::error("tar_append_eof failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  if (tar_close(tarball) != 0) {
    cerr << ttyHelper::error("tar_close failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }

  // get tarball
  const systemHelper::result<vector<unsigned char>> tarballFileResult =
      systemHelper::readFile(tmpPath + "/tarball.tar");
  if (tarballFileResult.exitCode != 0) {
    cerr << ttyHelper::error(*tarballFileResult.error);
    filesystem::remove_all(tmpPath);
    return 1;
  }
  const vector<unsigned char> tarballFileVec = *tarballFileResult.output;

  const unsigned int tarballLen = tarballFileVec.size();
  unsigned char *tarballFile = new unsigned char[tarballLen];
  copy(tarballFileVec.begin(), tarballFileVec.end(), tarballFile);

  // hash flakePath
  EVP_MD_CTX *ctx = EVP_MD_CTX_new();

  unsigned char SHA256Key[256];
  unsigned int SHA256Size = 256;
  if (EVP_DigestInit_ex(ctx, EVP_sha256(), NULL) != 0) {
    cerr << ttyHelper::error("EVP_DigestInit_ex(sha256) failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  if (EVP_DigestUpdate(ctx, &tarballFile, tarballLen) != 0) {
    cerr << ttyHelper::error("EVP_DigestUpdate Failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }
  delete[] tarballFile;
  if (EVP_DigestFinal_ex(ctx, SHA256Key, &SHA256Size) != 0) {
    cerr << ttyHelper::error("EVP_DigestFinal_ex failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }

  // get signing ssh pkey
  const systemHelper::result<vector<unsigned char>> privateKeyResult =
      systemHelper::readFile("");
  if (privateKeyResult.exitCode != 0) {
    cerr << ttyHelper::error(*privateKeyResult.error);
    filesystem::remove_all(tmpPath);
    return 1;
  }
  const vector<unsigned char> privateKeyVec = *privateKeyResult.output;

  const unsigned int privateKeySize = privateKeyVec.size();
  unsigned char *privateKeyFile = new unsigned char[privateKeySize];
  copy(privateKeyVec.begin(), privateKeyVec.end(), privateKeyFile);

  // sign flakePath
  EVP_PKEY *privateKey = EVP_PKEY_new_raw_private_key(
      EVP_PKEY_ED25519, NULL, privateKeyFile, privateKeySize);

  if (EVP_DigestSignInit(ctx, NULL, NULL, NULL, privateKey) != 0) {
    cerr << ttyHelper::error("EVP_DigestSignInit failed");
    filesystem::remove_all(tmpPath);
    return 1;
  };
  unsigned char signature[64];
  size_t signatureSize = 64;
  if (EVP_DigestSign(ctx, signature, &signatureSize, SHA256Key, SHA256Size) !=
      0) {
    cerr << ttyHelper::error("EVP_DigestSign failed");
    filesystem::remove_all(tmpPath);
    return 1;
  }

  cout << "signature: ";
  cout << signature;

  EVP_MD_CTX_free(ctx);
  EVP_PKEY_free(privateKey);
  delete[] privateKeyFile;

  // send flakePath
  // rebuild
  // done :3

  // filesystem::remove_all(tmpPath);
  return 0;
}
