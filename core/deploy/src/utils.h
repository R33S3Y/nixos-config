#pragma once

#include <string>
#include <vector>
using namespace std;

class utils {
public:
  static string runCommand(string cmd);
  static vector<string> splitStrByChar(string inputStr, char inputChar);
  static vector<string> splitStrByChars(string inputStr,
                                        vector<char> inputChars);
  static string replace(string s, string from, string to);
  static string replaceAll(string s, string from, string to);
  static string trim(string s);
  static string readFile(const string &path);
};
