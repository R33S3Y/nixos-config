#include <cstddef>
#include <libssh/libssh.h>
#include <sshHelper.h>
#include <string>
#include <termios.h>

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

sshHelper::result<void> sshHelper::runCommandOn(ssh_session session,
                                                string command) {
  ssh_channel channel = NULL;
  channel = ssh_channel_new(session);
  if (channel == NULL) {
    return {.exitCode = 1, .error = "ssh channel = NULL"};
  }

  // it is worth noting that we could add retry logic here and in other places.
  // But that sounds like a issue for future me :3
  if (ssh_channel_request_exec(channel, command.c_str()) != SSH_OK) {
    ssh_channel_free(channel);
    return {.exitCode = 1, .error = "failed to run command"};
  }
  string sterrStr;
  char sterrBuffer[2048];

  char stoutBuffer[2048];

  ssh_channel_free(channel);
  return {.exitCode = 0};
}
