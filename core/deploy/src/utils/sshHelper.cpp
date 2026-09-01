#include <cstddef>
#include <libssh/libssh.h>
#include <sshHelper.h>
#include <string>

using namespace std;

sshHelper::result<ssh_session>
sshHelper::connectTo(const string host, const string port, const string user,
                     const string password, const string privateKey) {
  ssh_session session = NULL;

  session = ssh_new();

  if (session == NULL) {
    return {.exitCode = 1, .error = "SSH session = NULL"};
  }

  if (ssh_options_set(session, SSH_OPTIONS_USER, user.c_str()) < 0) {
    ssh_free(session);
    return {.exitCode = 1, .error = "Failed to set user"};
  }
  if (ssh_options_set(session, SSH_OPTIONS_PORT_STR, port.c_str()) < 0) {
    ssh_free(session);
    return {.exitCode = 1, .error = "Failed to set port"};
  }
  if (ssh_options_set(session, SSH_OPTIONS_HOST, host.c_str()) < 0) {
    ssh_free(session);
    return {.exitCode = 1, .error = "Failed to set host"};
  }

  if (ssh_connect(session)) {

    string error = string(ssh_get_error(session));
    ssh_disconnect(session);
    ssh_free(session);
    return {.exitCode = 1, .error = "Failed to connect. \n" + error};
  }

  int auth;
  if (password.length() > 0) {
    auth = ssh_userauth_password(session, NULL, password.c_str());
  } else if (privateKey.size() > 0) {
    ssh_key sshKey = NULL;
    if (ssh_pki_import_privkey_base64(privateKey.c_str(), NULL, NULL, nullptr,
                                      &sshKey) != SSH_OK) {
      SSH_KEY_FREE(sshKey);
      ssh_disconnect(session);
      ssh_free(session);
      return {.exitCode = 1,
              .error = "ssh_pki_import_privkey_base64 failed. You may need to "
                       "add passphrase support"};
    }
    auth = ssh_userauth_try_publickey(session, NULL, sshKey);

    if (auth != SSH_AUTH_SUCCESS) {
      SSH_KEY_FREE(sshKey);
      ssh_disconnect(session);
      ssh_free(session);
      return {.exitCode = 1,
              .error =
                  "publicKey has been declined. Please provide different auth"};
    }

    auth = ssh_userauth_publickey(session, NULL, sshKey);
    SSH_KEY_FREE(sshKey);
  } else {
    return {.exitCode = 1, .error = "No password's or privateKey"};
  }

  if (auth == SSH_AUTH_SUCCESS) {
    return {.output = session, .exitCode = 0};
  }
  if (auth == SSH_AUTH_DENIED) {
    ssh_disconnect(session);
    ssh_free(session);
    return {.exitCode = 1, .error = "Authentication Failed"};
  }
  string error = string(ssh_get_error(session));
  ssh_disconnect(session);
  ssh_free(session);
  return {.exitCode = 1, .error = "Error while authenticating. \n" + error};
}
