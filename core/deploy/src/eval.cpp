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
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".", ""}},
      {"options",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".", ""}},
      {"lib",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".", ""}},
      {"pkgs",
       {"nix eval " + flakePath + "#nixosConfigurations." + host + ".", ""}},
  };
  throwMap = {
      {"builtins", {"nix eval --expr 'builtins", "'"}},
      {"inputs",
       {"nix eval " + flakePath + "#nixosConfigurations." + host +
            "._module.specialArgs.",
        ""}},
  };

  utils::result cmdOut = utils::runCommand(
      "nix eval " + flakePath + "#nixosConfigurations." + host +
      "._module.specialArgs --apply builtins.attrNames");

  if (!cmdOut.ok()) {
    cerr << utils::error("Failed to eval special args");
  }
  vector<string> list = eval::list(cmdOut.output);
  for (string item : list) {
    item = utils::replaceAll(item, "\"", "");
    if (item == "inputs")
      continue;
    eval::resolveMap.insert(
        {item,
         {"nix eval " + flakePath + "#nixosConfigurations." + host +
              "._module.specialArgs.",
          ""}});
  }
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
vector<string> eval::list(string test, bool throwLazy) {

  // mask and split
  string mask = test;
  mask = utils::blankWithinTokens(mask, "${", "}");
  mask = utils::blankWithinTokens(mask, "(", ")");
  vector<string> listItems = utils::splitStrByCharByFilterStr(test, mask, ' ');

  // is list and cleanup
  if (listItems.size() == 0) {
    return {};
  }
  for (int i = 0; i < listItems.size(); i++) {
    listItems[i] = utils::trim(listItems[i]);
    if (listItems[i].size() == 0) {
      listItems.erase(listItems.begin() + i);
      i--;
    }
  }
  if (listItems.size() == 0)
    return {};
  if (listItems.front() != "[" || listItems.back() != "]") {
    return {};
  }

  // throw lazy items
  for (int i = 0; i < listItems.size(); i++) {
    string listItem = listItems[i];

    if (listItem.find("«") != string::npos ||
        listItem.find("»") != string::npos) {
      // is lazy item like «thunk» or «lambda @ ...» or «github:...»
      if (throwLazy == false)
        continue;
      listItems.erase(listItems.begin() + i);
      i--;
      continue;
    }
  }
  return listItems;
}

eval::result eval::statement(string test, bool canThrow) {
  result res;

  res.str = path(test);
  if (res.str != "") {
    res.error = false;
    return res;
  }
  eval::result hold = attrsetKey(test, canThrow);
  if (hold.error == false) {
    res.str = hold.str;
    res.error = false;
    return res;
  }

  if (canThrow == true) {
    res.error = true;
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
eval::result eval::attrsetKey(string test, bool canThrow) {
  eval::result res;
  string attrset;

  // does preproccessing to resolve funny statements like ${ } and ( ) and get
  // a clean attrset Split
  string mask = test;
  mask = utils::blankWithinTokens(mask, "${", "}");
  mask = utils::blankWithinTokens(mask, "(", ")");
  mask = utils::blankWithinTokens(mask, "[", "]");
  vector<string> attrsetKeys =
      utils::splitStrByCharByFilterStr(test, mask, '.');

  // go though key by key and resolve thing like ${ }
  for (int i = 0; i < attrsetKeys.size(); i++) {
    string attrsetKey = attrsetKeys[i];

    // resolve ${ }
    if (attrsetKey.find("${") != string::npos &&
        attrsetKey.find("}", attrsetKey.find("${")) != string::npos) {
      attrsetKey = utils::replace(attrsetKey, "${", "");
      attrsetKey = utils::rReplace(attrsetKey, "}", "");

      eval::result hold = eval::statement(attrsetKey, false);
      if (hold.error == true) {
        res.error = true;
        break;
      }
      attrsetKey = hold.str;
    }

    // resolve ( )
    // todo...

    attrset += attrsetKey + ".";
  }
  if (res.error == true) {
    res.str = "";
    result res;
  }
  // remove trailing dot.
  if (attrset.back() == '.') {
    attrset = attrset.substr(0, attrset.size() - 1);
  }

  string cmd;
  if (resolveMap.count(attrsetKeys[0])) {
    cmd =
        resolveMap[attrsetKeys[0]][0] + attrset + resolveMap[attrsetKeys[0]][1];
  }
  if (throwMap.count(attrsetKeys[0]) && canThrow == false) {
    cmd = throwMap[attrsetKeys[0]][0] + attrset + throwMap[attrsetKeys[0]][1];
  }
  if (cmd == "") {
    res.error = true;
    return res;
  }
  cout << cmd;
  utils::result cmdOut = utils::runCommand(cmd);
  if (!cmdOut.ok()) {
    res.error = true;
    return res;
  }
  eval::result hold = eval::statement(cmdOut.output, true);
  if (hold.error == true) {
    res.error = true;
    return res;
  }
  res.str = hold.str;
  res.error = false;
  return res;
}
