#include "resolve.h"
#include "utils.h"
#include <algorithm>
#include <filesystem>
#include <format>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

resolve::resolve(const string &flakePath, const string &flakeLink)
    : flakePath(flakePath), flakeLink(flakeLink) {}

void resolve::preprocessFile(const string &filepath) {
  this->filepath = filepath;
  this->absoluteFilepath = flakePath + filepath;

  string rawFileStr = utils::readFile(flakePath + filepath);
  vector<string> lineFile = utils::splitStrByChar(rawFileStr, '\n');

  vector<string> stringTokens = {
      "\"",
      "''",
  };
  for (string stringToken : stringTokens) {
    while (rawFileStr.find(stringToken) != string::npos) {
      size_t start = rawFileStr.find(stringToken);
      size_t end = rawFileStr.find(stringToken, start + stringToken.size()) +
                   stringToken.size();

      if (end == string::npos) {
        break;
      }

      for (size_t i = start; i < end; i++) {
        if (rawFileStr[i] != '\n') {
          // cout << rawFileStr[i];
          rawFileStr[i] = ' ';
        }
      }
    }
  }
  vector<string> stringlessLinefile = utils::splitStrByChar(rawFileStr, '\n');

  string fileStr;
  this->prettyfile = {};
  for (int i = 0; i < lineFile.size(); i++) {
    string line = lineFile[i];
    this->prettyfile.push_back("\033[35m" + format("{:4}", i + 1) +
                               ":\033[0m " + line + "\n");

    if (stringlessLinefile[i].find("#") != string::npos) {
      line = line.substr(0, stringlessLinefile[i].find("#"));
    }
    fileStr += line + "\n";
  }

  this->fileStr = fileStr;
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
    lineStr = utils::replaceAll(lineStr, ";", "");
    lineStr = utils::trim(lineStr);

    string result = resolveKey(lineStr);
    if (result != "") {
      paths.push_back(result);
    }
  }
  return paths;
}

vector<string> resolve::resolveImportsStatements() {
  string workingFileStr = fileStr;

  vector<string> paths;
  while (workingFileStr.length() > 0) {
    size_t pos = workingFileStr.find("imports");
    if (pos == string::npos) {
      break;
    }
    workingFileStr = workingFileStr.substr(pos);

    size_t lineEnd = workingFileStr.find(";");

    string lineStr = workingFileStr.substr(0, lineEnd);
    workingFileStr = workingFileStr.substr(lineEnd);

    lineStr = utils::replaceAll(lineStr, "imports", "");
    lineStr = utils::trim(lineStr);

    if (lineStr[0] !=
        '=') { // incase you end up with: thing = var.imports ++ [];
      continue;
    }
    lineStr = utils::replaceAll(lineStr, "=", "");
    lineStr = utils::replaceAll(lineStr, "[", "");
    lineStr = utils::replaceAll(lineStr, "]", "");

    vector<string> items = utils::splitStrByChars(lineStr, {' ', '\n'});
    for (int i = 0; i < items.size(); i++) {
      string item = items[i];

      // input sanitization
      item = utils::replaceAll(item, ";", "");
      item = utils::trim(item);
      if (item == "") {
        continue;
      }

      // re-merge bracket statements
      if (item.find("(") != string::npos && item.find(")") == string::npos) {
        while (i + 1 < items.size() && items[i + 1].find(")") == string::npos) {
          item += " " + utils::trim(items[i + 1]);
          items.erase(items.begin() + i + 1);
        }
        if (i + 1 < items.size()) {
          item += " " + utils::trim(items[i + 1]);
          items.erase(items.begin() + i + 1);
        }
      }

      string result = resolveKey(item);
      if (result != "") {
        paths.push_back(result);
      }
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

  cerr << "\n\033[31mError\033[0m : Failed to resolve the following in "
          "(\033[35m" +
              flakeLink + filepath + "\033[0m)\n";
  string errorCode;
  vector<string> tokenTest = utils::splitStrByChar(test, '\n');
  for (int i = 0; i < prettyfile.size(); i++) {

    if (prettyfile[i].find(tokenTest[0]) == string::npos) {
      continue;
    }

    for (int j = i - 2; j < i + tokenTest.size() + 2; j++) {
      string line = prettyfile[j];

      if (i == j) {
        line = utils::replace(line, "\n", "");

        line += "    \033[31m<---\033[0m\n";
      }

      errorCode += line;
    }
  }
  if (errorCode.size() == 0) {
    errorCode = utils::trim(test) + "\n";
  }
  cerr << errorCode;
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

string resolve::resolveValue(string test) {}
