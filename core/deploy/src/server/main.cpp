#include "../utils/args.h"
#include "../utils/nixGet.h"
#include "../utils/split.h"
#include "../utils/systemHelper.h"
#include "../utils/ttyHelper.h"
#include <algorithm>
#include <cstddef>
#include <cstring>
#include <ctime>
#include <fcntl.h>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <libtar.h>
#include <map>
#include <nlohmann/json.hpp>
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
  systemHelper::result cmdOut;
  cmdOut = systemHelper::runCommand("nix flake clone " + flakeLink +
                                    " --dest " + flakePath);
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
      {
          "signing",
          {"user", user},
          {
              "time",
              static_cast<int64_t>(time(nullptr)),
          },
      },
      {"dynamic", dynamicRebuild},
  };
  ofstream out(tmpPath + "/manifest.json");
  out << to_string(manifestJson);
  out.close();

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

  // append nixos config
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
  // sign flakePath
  // send flakePath
  // rebuild
  // done :3

  // filesystem::remove_all(tmpPath);
  return 0;
}
