#include <optional>
#include <string>
#include <vector>

using namespace std;

namespace sslHelper {
template <typename T> struct result {
  optional<T> output;
  int exitCode;
  optional<string> error;
};
template <> struct result<void> {
  int exitCode;
  optional<string> error;
};

result<vector<unsigned char>> getSHA256Hash(const vector<unsigned char> data);
result<vector<unsigned char>>
getED25519Signature(const vector<unsigned char> data,
                    const vector<unsigned char> privateKey);
} // namespace sslHelper
