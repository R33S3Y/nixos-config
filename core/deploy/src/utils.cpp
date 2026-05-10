#include "utils.h"
#include <cstddef>
#include <cstdio>
#include <nlohmann/json.hpp>
#include <string>
#include <vector>

using namespace std;

string utils::runCommand(string cmd) {
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
vector<string> utils::splitStrByChar(string inputStr, char inputChar) {
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
  output.push_back(currentStr);
  return output;
}
string utils::replace(string s, string from, string to) {
  size_t pos = s.find(from);
  if (pos != string::npos) {
    s.replace(pos, from.size(), to);
  }
  return s;
}
string utils::trim(string s) {
  s.erase(0, s.find_first_not_of(" \t\n\r"));
  s.erase(s.find_last_not_of(" \t\n\r") + 1);
  return s;
}
