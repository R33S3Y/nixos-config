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

  auto json = nlohmann::json::parse(utils::runCommand(cmd));

  vector<string> configs;
  for (auto &[key, value] : json["nixosConfigurations"].items()) {
    configs.push_back(key);
  }

  return configs;
}
vector<string> getNixFiles(string flakeLink, string host) {
  string cmd = "nix eval " + flakeLink + "#nixosConfigurations." + host +
               "._module.args.modules";

  string cmdOut = utils::runCommand(cmd);

  vector<string> cmdOutSplit = utils::splitStrByChar(cmdOut, ' ');

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
vector<string> getOtherImports(string flakeLink, string flakePath,
                               vector<string> nixFiles) {
  vector<string> output;
  for (string nixFile : nixFiles) {
  }
  return output;
}

int main(int argc, char const *argv[]) {

  string flakeLink = "/home/reese/Desktop/nixos";
  string flakePath = "/tmp/currentConfig";

  filesystem::create_directories(flakePath);
  if (filesystem::is_empty(flakePath) == false) {
    cerr << "\n\033[31mError\033[0m : flakePath (\033[35m" + flakePath +
                "\033[0m) is not empty";
    return 1;
  }
  utils::runCommand("nix flake clone " + flakeLink + " --dest " + flakePath);

  vector<string> hosts = getFlakeInputs(flakePath);

  for (string host : hosts) {
    cout << "\n";
    cout << host + "\n";

    vector<string> unprocessedFiles = getNixFiles(flakePath, host);

    cout << "(" + unprocessedFiles.back() + ")";

    unprocessedFiles.push_back("/flake.nix");

    cout << "\n";
    cout << "Unprocessed files: \n";
    for (string file : unprocessedFiles) {
      cout << file + "\n";
    }

    vector<string> processedFiles;
    resolve r(flakePath, flakeLink);

    for (int i = 0; i < unprocessedFiles.size(); i++) {
      std::string filePath = unprocessedFiles[i];
      unprocessedFiles.erase(unprocessedFiles.begin() + i);
      processedFiles.push_back(filePath);

      r.preprocessFile(filePath);

      vector<string> imports = r.resolveImportStatements();

      imports.erase(remove_if(imports.begin(), imports.end(),
                              [&](const string &f) {
                                return find(processedFiles.begin(),
                                            processedFiles.end(),
                                            f) != processedFiles.end();
                              }),
                    imports.end());
      set<string> pending(unprocessedFiles.begin(), unprocessedFiles.end());
      pending.insert(imports.begin(), imports.end());
      unprocessedFiles.assign(pending.begin(), pending.end());
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
