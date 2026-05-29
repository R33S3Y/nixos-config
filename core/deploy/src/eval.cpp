#include "eval.h"
#include "utils.h"
#include <cstddef>
#include <filesystem>
#include <format>
#include <iostream>
#include <iterator>
#include <string>
#include <vector>
using namespace std;

eval::eval(const init &i) {
  flakePath = i.flakePath;
  flakeLink = i.flakeLink;
  host = i.host;

  resolveMap = {
      {"config",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".pkgs",
        ""}},
      {"options",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".pkgs",
        ""}},
      {"lib",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".pkgs",
        ""}},
      {"pkgs",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".pkgs",
        ""}},
  };
  throwMap = {
      {"builtins", {"nix eval --expr 'builtins", "'"}},
  };
}

void eval::preProcessFile(string fileStr, string filePath) {

  eval::fileStr = removeComments(fileStr);
  eval::filePath = filePath;
  eval::absoluteFilePath = flakePath + filePath;

  // make pretty string for error logs
  vector<string> lineFile = utils::splitStrByChar(fileStr, '\n');

  eval::prettyFile = {};
  for (int i = 0; i < lineFile.size(); i++) {
    string line = lineFile[i];

    eval::prettyFile.push_back("\033[35m" + format("{:4}", i + 1) +
                               ":\033[0m " + line + "\n");
  }
  return;
}

string eval::removeComments(string fileStr) {

  // gets the things before the strings are moved
  vector<string> lineFile = utils::splitStrByChar(fileStr, '\n');

  // removes the contents inside str
  fileStr = utils::blankWithinTokens(fileStr, "\"");
  fileStr = utils::blankWithinTokens(fileStr, "''");

  // removes  comments from filestr so it can be useful
  vector<string> stringlessLineFile = utils::splitStrByChar(fileStr, '\n');
  string output;
  for (int i = 0; i < lineFile.size(); i++) {
    string line = lineFile[i];
    if (stringlessLineFile[i].find("#") != string::npos) {
      line = line.substr(0, stringlessLineFile[i].find("#"));
    }
    output += line + "\n";
  }

  return output;
}

eval::result eval::statement(string test) {
  result res;

  res.str = path(test);
  if (res.str != "") {
    res.error = false;
    return res;
  }
  res.str = attrsetKey(test);
  if (res.str != "") {
    res.error = false;
    return res;
  }

  cerr << "\n\033[31mError\033[0m : Failed to resolve the following in "
          "(\033[35m" +
              eval::flakeLink + eval::filePath + "\033[0m)\n";
  string errorCode;
  vector<string> tokenTest = utils::splitStrByChar(test, '\n');
  for (int i = 0; i < eval::prettyFile.size(); i++) {

    if (eval::prettyFile[i].find(tokenTest[0]) == string::npos) {
      continue;
    }

    for (int j = i - 2; j < i + tokenTest.size() + 2; j++) {
      string line = eval::prettyFile[j];

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
  res.error = true;
  return res;
}

string eval::path(string test) {
  if (test.find(" ") != string::npos) {
    test = test.substr(0, test.find(" "));
  }

  if (test[0] == '/') {
    // is absolute file path
    if (test.rfind(eval::flakePath, 0) == 0) {
      test = utils::replace(test, eval::flakePath, "");
      return test;
    }
    if (test.rfind(eval::flakeLink, 0) == 0) {
      test = utils::replace(test, eval::flakeLink, "");
      return test;
    }
  }

  string absoluteFolderPath =
      eval::absoluteFilePath.substr(0, eval::absoluteFilePath.rfind('/'));
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

      std::filesystem::path declaredIn = absoluteFilePath;
      std::filesystem::path relative = test;
      string path =
          filesystem::weakly_canonical(declaredIn.parent_path() / relative)
              .string();

      if (path.rfind(eval::flakePath, 0) == 0) {
        path = utils::replace(path, eval::flakePath, "");
        return path;
      }
      if (path.rfind(eval::flakeLink, 0) == 0) {
        return path;
      }
    }
  }
  return "";
}

string eval::attrsetKey(string test) {

  // does preproccessing to resolve funny statements like ${ } and ( )
  string hold = test;
  hold = utils::blankWithinTokens(hold, "${", "}");
  hold = utils::blankWithinTokens(hold, "(", ")");
  vector<string> attrsetKeys =
      utils::splitStrByCharByFilterStr(test, hold, '.');
  for (int i = 0; i < attrsetKeys.size(); i++) {
    cout << attrsetKeys[i] + "\n";
  }
  return "";
}
