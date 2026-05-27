#pragma once

#include <map>
#include <shared_mutex>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

class resolve {
public:
  resolve(const string &flakePath, const string &flakeLink, const string &host);

  struct result {
    bool error = false;
    string str;
    vector<string> paths;
  };

  void preprocessFile(const string &filepath);
  result resolveImportStatements();
  result resolveImportsStatements();
  result resolveKey(string test);
  string resolvePath(string test);
  string resolveValue(string test);

private:
  string flakePath;
  string flakeLink;
  string absoluteFilePath;
  string filePath;
  string fileStr;
  string host;
  vector<string> prettyfile;
  map<string, string> resolveMap;
  map<string, string> throwMap;
};
