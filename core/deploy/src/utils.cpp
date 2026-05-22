#include "utils.h"
#include <algorithm>
#include <cerrno>
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <fstream>
#include <nlohmann/json.hpp>
#include <sstream>
#include <stdexcept>
#include <string>
#include <sys/wait.h>
#include <vector>

using namespace std;

struct result {
  string output;
  int exitCode;
  string error;

  bool ok() const { return exitCode == 0; }
};

result utils::runCommand(string cmd) {
  result res;

  FILE *pipe = popen(cmd.c_str(), "r");
  if (!pipe) {
    res.exitCode = -1;
    res.error = strerror(errno);
    return res;
  }

  char buffer[256];
  while (fgets(buffer, sizeof(buffer), pipe))
    res.output += buffer;

  int status = pclose(pipe);
  res.exitCode = (status == -1) ? -1 : WEXITSTATUS(status);
  return res;
}
vector<string> utils::splitStrByChars(string inputStr,
                                      vector<char> inputChars) {
  vector<string> output;
  string currentStr;

  for (char currentChar : inputStr) {
    if (find(inputChars.begin(), inputChars.end(), currentChar) !=
        inputChars.end()) {
      output.push_back(currentStr);
      currentStr.clear();
    } else {
      currentStr += currentChar;
    }
  }
  output.push_back(currentStr);
  return output;
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
string utils::replaceAll(string s, string from, string to) {
  while (s.find(from) != string::npos) {
    size_t pos = s.find(from);
    if (pos != string::npos) {
      s.replace(pos, from.size(), to);
    }
  }
  return s;
}
string utils::trim(string s) {
  s.erase(0, s.find_first_not_of(" \t\n\r"));
  s.erase(s.find_last_not_of(" \t\n\r") + 1);
  return s;
}
string utils::readFile(const string &path) {
  ifstream file(path);
  if (!file.is_open())
    throw runtime_error("Failed to open file: " + path);
  ostringstream ss;
  ss << file.rdbuf();
  return ss.str();
}
