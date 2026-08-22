#pragma once

#include <map>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

namespace ttyHelper {
const string error(string message);
const string warning(string message);
const string log(string message);
const string progressBar(const int progress, const int total, const int chars);
} // namespace ttyHelper
namespace ttyColour {
const string reset = "\033[0m";
const string error = "\033[31m";
const string warning = "\033[33m";
const string log = "\033[32m";
} // namespace ttyColour
