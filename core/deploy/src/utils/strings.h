#pragma once

#include <string>
using namespace std;

namespace strings {

string replace(string s, string from, string to);

// reverse Replace
string rReplace(string s, string from, string to);
string replaceAll(string s, string from, string to);

string trim(string s);

string blankWithinTokens(string fileStr, string startToken,
                         string endToken = "", char blankChar = ' ');
} // namespace strings
