#include <openssl/evp.h>
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

const result<vector<unsigned char>>
getSHA512Hash(const vector<unsigned char> data);

const result<EVP_PKEY *>
openPrivateKey(const vector<unsigned char> privateKeyFile);
const result<EVP_PKEY *>
openPublicKey(const vector<unsigned char> publicKeyFile);

const result<vector<unsigned char>>
signDataWithKey(const vector<unsigned char> data, EVP_PKEY *privateKey);
const result<bool> verifySignatureWithKey(const vector<unsigned char> data,
                                          const vector<unsigned char> sign,
                                          EVP_PKEY *publicKey);
} // namespace sslHelper
