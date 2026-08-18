#include "sslHelper.h"
#include <openssl/evp.h>
#include <vector>

using namespace std;

sslHelper::result<vector<unsigned char>>
sslHelper::getSHA256Hash(vector<unsigned char> data) {

  const unsigned int dataLen = data.size();
  unsigned char *dataArray = new unsigned char[dataLen];
  copy(data.begin(), data.end(), dataArray);

  // hash flakePath
  EVP_MD_CTX *ctx = EVP_MD_CTX_new();

  unsigned char SHA256Key[256];
  unsigned int SHA256Size = 256;
  if (EVP_DigestInit(ctx, EVP_sha256()) != 0) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestInit_ex Failed"};
  }
  if (EVP_DigestUpdate(ctx, &dataArray, dataLen) != 0) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestUpdate Failed"};
  }
  delete[] dataArray;
  if (EVP_DigestFinal_ex(ctx, SHA256Key, &SHA256Size) != 0) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestFinal_ex failed"};
  }
  EVP_MD_CTX_free(ctx);

  vector<unsigned char> output(SHA256Key, SHA256Key + SHA256Size);
  return {.output = output, .exitCode = 0};
}

sslHelper::result<vector<unsigned char>>
sslHelper::getED25519Signature(const vector<unsigned char> data,
                               const vector<unsigned char> privateKey) {

  const unsigned int privateKeySize = privateKey.size();
  unsigned char *privateKeyArr = new unsigned char[privateKeySize];
  copy(privateKey.begin(), privateKey.end(), privateKeyArr);

  // sign flakePath
  EVP_PKEY *privateKeyPKEY = EVP_PKEY_new_raw_private_key(
      EVP_PKEY_ED25519, NULL, privateKeyArr, privateKeySize);

  EVP_MD_CTX *ctx = EVP_MD_CTX_new();

  if (EVP_DigestSignInit(ctx, NULL, NULL, NULL, privateKeyPKEY) != 0) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestSignInit failed"};
  };
  unsigned char signature[64];
  size_t signatureSize = 64;

  const unsigned int dataSize = data.size();
  unsigned char *dataArr = new unsigned char[dataSize];
  copy(data.begin(), data.end(), dataArr);

  if (EVP_DigestSign(ctx, signature, &signatureSize, dataArr, dataSize) != 0) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestSign failed"};
  }

  EVP_MD_CTX_free(ctx);
  EVP_PKEY_free(privateKeyPKEY);
  delete[] privateKeyArr;

  vector<unsigned char> output(signature, signature + signatureSize);
  return {.output = output, .exitCode = 0};
}
