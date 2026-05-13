#pragma once

#include <shared_mutex>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

class resolve {
public:
  resolve(const string &flakePath, const string &flakeLink);

  void preprocessFile(const string &absoluteFilepath);
  vector<string> resolveImportStatements();
  string resolveKey(string test);
  string resolvePath(string test);
  string resolveValue(string test);

private:
  string flakePath;
  string flakeLink;
  string absoluteFilepath;
  string fileStr;
};
