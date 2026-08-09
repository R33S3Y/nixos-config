#pragma once
#include <optional>
#include <string>
#include <vector>
using namespace std;

namespace tar {
template <typename T> struct result {
  optional<T> output;
  int exitCode;
  optional<string> error;
};
template <> struct result<void> {
  int exitCode;
  optional<string> error;
};

result<void> package(string tarName, string tarPath, vector<string> tarContent);
result<vector<string>> unpackage(string tarName, string tarPath);
} // namespace tar
