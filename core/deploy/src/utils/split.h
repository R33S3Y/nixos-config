#pragma once

#include <map>
#include <string>
#include <type_traits>
#include <vector>
using namespace std;

namespace split {
vector<string> splitStrByChar(string inputStr, char inputChar);
vector<string> splitStrByChars(string inputStr, vector<char> inputChars);
vector<string> splitStrByCharByFilterStr(string inputStr, string filterStr,
                                         char inputChar);
vector<string> splitStrByCharsByFilterStr(string inputStr, string filterStr,
                                          vector<char> inputChars);

template <typename type>
vector<vector<type>> splitVector(vector<type> vec, int splits);

template <typename keyType, typename valueType>
vector<map<keyType, valueType>> splitMap(map<keyType, valueType> inputMap,
                                         int splits);
} // namespace split

#include "split.tpp"
