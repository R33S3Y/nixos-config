#include "resolve.h"
#include "utils.h"
#include <algorithm>
#include <filesystem>
#include <iostream>
#include <nlohmann/json.hpp>
#include <set>
#include <string>
#include <vector>

using namespace std;

vector<string> getFlakeInputs(string flakeLink) {
  string cmd = "nix flake show " + flakeLink + " --json";
  utils::result cmdOut = utils::runCommand(cmd);

  if (!cmdOut.ok()) {
    return {};
  }
  auto json = nlohmann::json::parse(cmdOut.output);

  vector<string> configs;
  for (auto &[key, value] : json["nixosConfigurations"].items()) {
    configs.push_back(key);
  }

  return configs;
}
vector<string> getNixFiles(string flakeLink, string host) {
  string cmd = "nix eval " + flakeLink + "#nixosConfigurations." + host +
               "._module.args.modules";

  utils::result cmdOut = utils::runCommand(cmd);

  if (!cmdOut.ok()) {
    cerr << "\n\033[31mError\033[0m : Failed to eval for nix files";
    return {};
  }

  vector<string> cmdOutSplit = utils::splitStrByChar(cmdOut.output, ' ');

  vector<string> output;

  for (string currentStr : cmdOutSplit) {
    if (currentStr.find(flakeLink) != string::npos) {

      string delim = "»";
      size_t pos = currentStr.find(delim);
      if (pos != string::npos) {
        currentStr = currentStr.substr(pos + delim.size());
      }

      currentStr = utils::replace(currentStr, flakeLink, "");
      currentStr = utils::trim(currentStr);

      if (currentStr != "") {
        output.push_back(currentStr);
      }
    }
  }

  return output;
}
vector<string> filter(vector<string> imports, vector<string> processedFiles) {
  imports.erase(remove_if(imports.begin(), imports.end(),
                          [&](const string &f) {
                            return find(processedFiles.begin(),
                                        processedFiles.end(),
                                        f) != processedFiles.end();
                          }),
                imports.end());

  return imports;
}
vector<string> merge(vector<string> imports, vector<string> unprocessedFiles) {
  set<string> pending(unprocessedFiles.begin(), unprocessedFiles.end());
  pending.insert(imports.begin(), imports.end());
  unprocessedFiles.assign(pending.begin(), pending.end());
  return unprocessedFiles;
}
int main(int argc, char const *argv[]) {

  string flakeLink = "/home/reese/Projects/nixos-config";
  string flakePath = "/tmp/currentConfig";

  filesystem::create_directories(flakePath);
  if (filesystem::is_empty(flakePath) == false) {
    cerr << "\n\033[31mError\033[0m : flakePath (\033[35m" + flakePath +
                "\033[0m) is not empty";
    return 1;
  }
  utils::result cmdOut = utils::runCommand("nix flake clone " + flakeLink +
                                           " --dest " + flakePath);
  if (!cmdOut.ok()) {
    cerr << "\n\033[31mError\033[0m : failed to get flake (\033[35m" +
                flakeLink + "\033[0m)";
    return 1;
  }

  vector<string> hosts = getFlakeInputs(flakePath);
  if (hosts.size() == 0) {
    cerr << "\n\033[31mError\033[0m : flake does not contain any hosts or no "
            "hosts could be found";
    return 1;
  }

  for (string host : hosts) {
    cout << "\n";
    cout << host + "\n";

    // in the case of a error while getting a file paths.
    // We have to rebuild the machine no matter what seeing as we may have just
    // missed the file that changed
    bool isError = false;

    vector<string> unprocessedFiles = getNixFiles(flakePath, host);

    // the only way this could happen is if getNixFiles had a error/failed
    if (unprocessedFiles.size() == 0) {
      isError = true;
    }

    unprocessedFiles.push_back("/flake.nix");

    vector<string> processedFiles;
    processedFiles.push_back("/flake.lock");

    cout << "\n";
    cout << "Unprocessed files: \n";
    for (string file : unprocessedFiles) {
      cout << file + "\n";
    }

    resolve r(flakePath, flakeLink);

    while (unprocessedFiles.size() != 0 && isError == false) {
      std::string filePath = unprocessedFiles[0];
      unprocessedFiles.erase(unprocessedFiles.begin());
      processedFiles.push_back(filePath);

      r.preprocessFile(filePath);
      vector<string> imports;

      imports = r.resolveImportStatements();
      imports = filter(imports, processedFiles);
      unprocessedFiles = merge(imports, unprocessedFiles);

      imports = r.resolveImportsStatements();

      imports = filter(imports, processedFiles);

      unprocessedFiles = merge(imports, unprocessedFiles);
    }
    cout << "\n";
    cout << "Processed files: \n";
    for (string file : processedFiles) {
      cout << file + "\n";
    }
  }

  filesystem::remove_all(flakePath);

  return 0;
}
