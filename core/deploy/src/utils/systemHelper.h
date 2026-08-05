#pragma once

#include <cstddef>
#include <map>
#include <optional>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

namespace systemHelper {

template <typename T> struct result {
  optional<T> output;
  int exitCode;
  optional<string> error;
};
template <> struct result<void> {
  int exitCode;
  optional<string> error;
};

static result<string> runCommand(string cmd);
static result<string> readFileToStr(const striqng &path);
static result<vector<unsigned char>> readFile(const string &path);
static result<void> saveFileFromStr(const string &path, const string &content);
}; // namespace systemHelper
