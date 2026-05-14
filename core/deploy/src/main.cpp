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
  string cmd = "nix flakeLink show " + flakeLink + " --json";

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

      output.push_back(currentStr);
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

  if (!filesystem::exists(flakePath)) {
    cerr << "Error : flakePath (" + flakePath + ") is not empty";
    return 1;
  }
  filesystem::create_directories(flakePath);
  utils::runCommand("nix flake clone " + flakeLink + " --dest " + flakePath);

  vector<string> hosts = getFlakeInputs(flakePath);

  for (string host : hosts) {
    cout << host + "\n";
    cout << "\n";

    vector<string> unprocessedFiles = getNixFiles(flakePath, host);
    unprocessedFiles.push_back("/flake.nix");

    vector<string> processedFiles;
    resolve r(flakePath, flakeLink);

    for (int i = 0; i < unprocessedFiles.size(); i++) {
      std::string filePath = unprocessedFiles[i];
      unprocessedFiles.erase(unprocessedFiles.begin() + i);
      processedFiles.push_back(filePath);

      cout << filePath + "\n";

      const string fullFilePath = flakePath + filePath;
      r.preprocessFile(fullFilePath);

      vector<string> hold = r.resolveImportStatements();
      hold.erase(remove_if(hold.begin(), hold.end(),
                           [&](const std::string &x) {
                             return find(processedFiles.begin(),
                                         processedFiles.end(),
                                         x) != processedFiles.end();
                           }),
                 hold.end());
      set<string> s(unprocessedFiles.begin(), unprocessedFiles.end());
      s.insert(hold.begin(), hold.end());
      unprocessedFiles = vector<string>(s.begin(), s.end());
    }
    cout << "\n";
  }

  filesystem::remove_all(flakePath);

  return 0;
}
