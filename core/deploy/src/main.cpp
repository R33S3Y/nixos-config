#include "utils.h"
#include <nlohmann/json.hpp>
#include <string>
#include <vector>

using namespace std;

vector<string> getFlakeInputs(string flake) {
  string cmd = "nix flake show " + flake + " --json";

  auto json = nlohmann::json::parse(utils::runCommand(cmd));

  vector<string> configs;
  for (auto &[key, value] : json["nixosConfigurations"].items()) {
    configs.push_back(key);
  }

  return configs;
}
vector<string> getNixFiles(string flake, string host) {
  string cmd = "nix eval " + flake + "#nixosConfigurations." + host +
               "._module.args.modules";

  string cmdOut = utils::runCommand(cmd);

  vector<string> cmdOutSplit = utils::splitStrByChar(cmdOut, ' ');

  vector<string> output;

  for (string currentStr : cmdOutSplit) {
    if (currentStr.find(flake) != string::npos) {

      string delim = "»";
      size_t pos = currentStr.find(delim);
      if (pos != string::npos) {
        currentStr = currentStr.substr(pos + delim.size());
      }

      currentStr = utils::replace(currentStr, flake, "");
      currentStr = utils::trim(currentStr);

      output.push_back(currentStr);
    }
  }

  return output;
}
int main(int argc, char const *argv[]) {

  string flake = "/home/reese/Desktop/nixos";
  // Get flake input
  vector<string> hosts = getFlakeInputs(flake);

  for (string host : hosts) {
    cout << host + "\n";
    cout << "\n";

    vector<string> nixFiles = getNixFiles(flake, host);
    for (string nixFile : nixFiles) {
      cout << nixFile + "\n";
    }
    cout << "\n";
  }

  return 0;
}
