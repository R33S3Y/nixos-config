#pragma once

#include <cstddef>
#include <map>
#include <optional>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

class systemHelper {
public:
  template <typename type> struct result {
    optional<type> output;
    int exitCode;
    optional<string> error;
  };
  template <> struct result<void> {
    int exitCode;
    optional<string> error;
  };

  static result<string> runCommand(string cmd);
  static result<string> readFileToStr(const string &path);
  static result<vector<unsigned char>> readFile(const string &path);
  static result<void> saveFileFromStr(const string &path,
                                      const string &content);
};
