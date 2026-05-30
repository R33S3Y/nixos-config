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
    string type;
    string str;
    vector<string> list;
  };

  static string removeComments(string fileStr);
  static vector<string> list(string test, bool throwLazy = true);

  result statement(string test, bool canThrow = true);
  string path(string test);
  result attrsetKey(string test, bool canThrow);

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
