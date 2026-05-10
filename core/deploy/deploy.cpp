#include <cstddef>
#include <cstdio>
#include <iostream>
#include <nlohmann/json.hpp>
#include <string>
#include <vector>

using namespace std;

string runCommand(string cmd) {
  string result;

  FILE *pipe = popen(cmd.c_str(), "r");
  if (!pipe)
    return "";

  char buffer[256];
  while (fgets(buffer, sizeof(buffer), pipe)) {
    result += buffer;
  }

  pclose(pipe);

  return result;
}
vector<string> splitStrByChar(string inputStr, char inputChar) {
  vector<string> output;
  string currentStr;

  for (char currentChar : inputStr) {
    if (currentChar == inputChar) {
      output.push_back(currentStr);
      currentStr.clear();
    } else {
      currentStr += currentChar;
    }
  }

  return output;
}
string replace(string s, string from, string to) {
  size_t pos = s.find(from);
  if (pos != string::npos) {
    s.replace(pos, from.size(), to);
  }
  return s;
}
string trim(string s) {
  s.erase(0, s.find_first_not_of(" \t\n\r"));
  s.erase(s.find_last_not_of(" \t\n\r") + 1);
  return s;
}

vector<string> getFlakeInputs(string flake) {
  string cmd = "nix flake show " + flake + " --json";

  auto json = nlohmann::json::parse(runCommand(cmd));

  vector<string> configs;
  for (auto &[key, value] : j["nixosConfigurations"].items()) {
    configs.push_back(key);
  }

  return configs;
}
vector<string> getNixFiles(string flake, string host) {
  string cmd = "nix eval " + flake + "#nixosConfigurations." + host +
               "._module.args.modules";

  string cmdOut = runCommand(cmd);
  vector<string> cmdOutSplit = splitStrByChar(cmdOut, " ");

  vector<string> output;

  for (string currentStr : cmdOutSplit) {
    if (currentStr.find(flake) != string::npos) {

      string delim = "»";
      size_t pos = currentStr.find(delim);
      if (pos != string::npos) {
        currentStr = currentStr.substr(pos + delim.size());
      }

      currentStr = replace(currentStr, flake, "");
      currentStr = trim(currentStr);

      output.push_back(currentStr);
    }
  }

  if (pos != string::npos)
    = s.substr(pos + delim.size());
}
int main(int argc, char const *argv[]) {

  string flake "~/Desktop/nixos";
  // Get flake input
  vector<string> hosts = getFlakeInputs(flake);

  for (string host : hosts) {
    cout << host;
    vector<string> nixFiles = getNixFiles(flake, host);
    for (string nixFile : nixFiles) : {
      cout << nixFile;
    }
  }

  return 0;
}
