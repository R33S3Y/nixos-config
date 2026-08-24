#include "sslHelper.h"
#include <cstddef>
#include <openssl/bio.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/pem.h>
#include <openssl/provider.h>
#include <vector>

using namespace std;

const sslHelper::result<void> sslHelper::openSSLInIt() {
  OSSL_PROVIDER_load(nullptr, "default");
  return {.exitCode = 0};
}

const sslHelper::result<vector<unsigned char>>
sslHelper::getSHA512Hash(const vector<unsigned char> data) {

  const unsigned int dataLen = data.size();
  unsigned char *dataArray = new unsigned char[dataLen];
  copy(data.begin(), data.end(), dataArray);

  EVP_MD_CTX *ctx = EVP_MD_CTX_new();

  unsigned char SHA256Key[EVP_MAX_MD_SIZE];
  unsigned int SHA256Size = EVP_MAX_MD_SIZE;
  if (EVP_DigestInit(ctx, EVP_sha512()) != 1) { // 1 = succeed, 0 = failed
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestInit Failed"};
  }
  if (EVP_DigestUpdate(ctx, dataArray, dataLen) != 1) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestUpdate Failed"};
  }
  delete[] dataArray;
  if (EVP_DigestFinal_ex(ctx, SHA256Key, &SHA256Size) != 1) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestFinal_ex failed"};
  }
  EVP_MD_CTX_free(ctx);

  vector<unsigned char> output(SHA256Key, SHA256Key + SHA256Size);
  return {.output = output, .exitCode = 0};
}

const sslHelper::result<EVP_PKEY *>
sslHelper::openPrivateKey(const vector<unsigned char> privateKeyFile) {
  EVP_PKEY *privateKeyPKEY = nullptr;

  BIO *bio = BIO_new_mem_buf(privateKeyFile.data(), (int)privateKeyFile.size());
  if (!bio) {
    return {.exitCode = 1, .error = "BIO_new_mem_buf failed"};
  }

  privateKeyPKEY = PEM_read_bio_PrivateKey(bio, nullptr, nullptr, nullptr);

  if (!privateKeyPKEY) {
    unsigned long errCode = ERR_get_error();
    char errBuf[256];
    ERR_error_string_n(errCode, errBuf, sizeof(errBuf));
    string errStr(errBuf);
    if (errStr.find("bad password") != string::npos ||
        errStr.find("bad decrypt") != string::npos) {
      return {
          .exitCode = 1,
          .error = "Key requires password. Add support for password to func or "
                   "cry :3",
      };
    }
    return {.exitCode = 1, .error = errStr};
  }
  return {.output = privateKeyPKEY, .exitCode = 0};
}

const sslHelper::result<vector<unsigned char>>
sslHelper::signDataWithKey(const vector<unsigned char> data,
                           EVP_PKEY *privateKey) {

  if (!privateKey) {
    return {.exitCode = 1, .error = "privateKey isn't valid"};
  }

  EVP_MD_CTX *ctx = EVP_MD_CTX_new();

  if (EVP_DigestSignInit_ex(ctx, NULL, NULL, NULL, NULL, privateKey, NULL) !=
      1) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestSignInit_ex failed"};
  };
  unsigned char signature[EVP_MAX_MD_SIZE];
  size_t signatureSize = EVP_MAX_MD_SIZE;

  const unsigned int dataSize = data.size();
  unsigned char *dataArr = new unsigned char[dataSize];
  copy(data.begin(), data.end(), dataArr);

  if (EVP_DigestSign(ctx, signature, &signatureSize, dataArr, dataSize) != 1) {
    EVP_MD_CTX_free(ctx);
    return {.exitCode = 1, .error = "EVP_DigestSign failed"};
  }

  EVP_MD_CTX_free(ctx);

  vector<unsigned char> output(signature, signature + signatureSize);
  return {.output = output, .exitCode = 0};
}
