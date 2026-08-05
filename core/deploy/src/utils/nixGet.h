#pragma once

#include <map>
#include <string>
#include <vector>
using namespace std;

namespace nixGet {

vector<string> flakeHosts(string flakePath);
string futureDerivationPath(string flakePath, string host);
string currentDerivationPath();
} // namespace nixGet
