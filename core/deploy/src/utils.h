#pragma once

#include <string>
#include <vector>
using namespace std;

class utils {
public:
  static string runCommand(string cmd);
  static vector<string> splitStrByChar(string inputStr, char inputChar);
  static string replace(string s, string from, string to);
  static string trim(string s);
}
