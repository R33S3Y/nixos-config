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

  vector<string> lineFile =
      utils::splitStrByChar(utils::readFile(flakePath + filepath), '\n');
  string fileStr;
  string prettyfileStr;
  bool inQuotes = false;
  for (int i = 0; i < lineFile.size(); i++) {
    string line = lineFile[i];
    this->prettyfile.push_back(to_string(i + 1) + ". " + line + "\n");

    if (line.find("''"))
      inQuotes = !inQuotes;

    if (line.find("#") != string::npos && inQuotes == false) {
      line = line.substr(0, line.find("#"));
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

        line += "    \n\033<---\033[0m)\n"
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
