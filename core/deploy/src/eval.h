#pragma once

#include <map>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

class eval {
public:
  struct init {
    string flakePath;
    string flakeLink;
    string host;
  };
  eval(const init &i);
  void preProcessFile(string fileStr, string filePath);

  struct result {
    bool error = false;
    string str;
    vector<string> paths;
  };

  static string blankStrings(string fileStr);
  static string blankInnerAntiQuotation(string filestr);
  static string removeComments(string fileStr);

  result statement(string test);
  string path(string test);
  string attrsetKey(string test);

private:
  string flakePath;
  string flakeLink;
  string host;

  string fileStr;
  string filePath;
  string absoluteFilePath;
  vector<string> prettyFile;

  map<string, vector<string>> resolveMap;
  map<string, vector<string>> throwMap;
};
