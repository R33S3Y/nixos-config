#pragma once

#include <map>
#include <optional>
#include <string>
#include <vector>
using namespace std;

namespace args {

struct optionIn {
  string longName;
  optional<char> shortName;
  bool takesValue = false;
  bool required = false;
};
struct optionOut {
  string longName;
  bool invoked;
  optional<char> shortName;
  optional<string> value;
};
map<string, optionOut> parse(vector<string> userInput,
                             map<string, optionIn> argValues);
} // namespace args
