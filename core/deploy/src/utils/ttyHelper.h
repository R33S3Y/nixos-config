#pragma once

#include <map>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

namespace ttyHelper {

string error(string message);
string warning(string message);
string progressBar(const int progress, const int total, const int chars);
} // namespace ttyHelper
