#include "resolve.h"
#include "utils.h"
#include <algorithm>
#include <filesystem>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

resolve::resolve(const string &flakePath, const string &flakeLink)
    : flakePath(flakePath), flakeLink(flakeLink) {}

void resolve::preprocessFile(const string &filepath) {
  this->filepath = filepath;
  this->absoluteFilepath = flakePath + filepath;
  this->fileStr = utils::readFile(flakePath + filepath);
  return;
}

vector<string> resolve::resolveImportStatements() {
  string workingFileStr = fileStr;

  vector<string> paths;
  while (workingFileStr.length() > 0) {
    size_t pos = workingFileStr.find("import ");
    if (pos == string::npos) {
      break;
    }
    workingFileStr = workingFileStr.substr(pos);

    size_t lineEnd = workingFileStr.find(";");
    string lineStr = workingFileStr.substr(0, lineEnd);
    workingFileStr = workingFileStr.substr(lineEnd);

    lineStr = utils::replace(lineStr, "import ", "");
    lineStr = utils::replace(lineStr, ";", "");
    lineStr = utils::trim(lineStr);

    string result = resolveKey(lineStr);
    if (result != "") {
      paths.push_back(result);
    }
  }
  return paths;
}

string resolve::resolveKey(string test) {
  string result;

  result = resolvePath(test);
  if (result != "") {
    return result;
  }

  cerr << "\n\033[31mError\033[0m : Failed to resolve the following in ("
          "\033[35m" +
              flakeLink + filepath + "\033[0m)\n";
  cerr << utils::trim(test) + "\n";
  return "";
}

string resolve::resolvePath(string test) {
  if (test.find(" ") != string::npos) {
    test = test.substr(0, test.find(" "));
  }

  if (test[0] == '/') {
    // is absolute file path
    if (test.rfind(flakePath, 0) == 0) {
      test = utils::replace(test, flakePath, "");
      return test;
    }
    if (test.rfind(flakeLink, 0) == 0) {
      test = utils::replace(test, flakeLink, "");
      return test;
    }
  }

  string absoluteFolderPath =
      absoluteFilepath.substr(0, absoluteFilepath.rfind('/'));
  vector<string> folders;
  for (auto &entry : std::filesystem::directory_iterator(absoluteFolderPath)) {
    if (entry.is_directory())
      folders.push_back(entry.path().string());
  }

  size_t pos = test.find('/');
  if (pos != string::npos) {

    string firstItem = test.substr(pos);

    if (test[0] == '.' ||
        find(folders.begin(), folders.end(), firstItem) != folders.end()) {
      // relative file path

      std::filesystem::path declaredIn = absoluteFilepath;
      std::filesystem::path relative = test;
      string path =
          filesystem::weakly_canonical(declaredIn.parent_path() / relative)
              .string();

      if (path.rfind(flakePath, 0) == 0) {
        path = utils::replace(path, flakePath, "");
        return path;
      }
      if (path.rfind(flakeLink, 0) == 0) {
        return path;
      }
    }
  }
  return "";
}
