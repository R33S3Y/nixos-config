#include <cstddef>
#include <fcntl.h>
#include <libssh/libssh.h>
#include <libssh/sftp.h>
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
    sshHelper::disconnect(session);
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
      sshHelper::disconnect(session);
      return {.exitCode = 1,
              .error = "ssh_pki_import_privkey_base64 failed. You may need to "
                       "add passphrase support"};
    }
    auth = ssh_userauth_try_publickey(session, NULL, sshKey);

    if (auth != SSH_AUTH_SUCCESS) {
      SSH_KEY_FREE(sshKey);
      sshHelper::disconnect(session);
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
    sshHelper::disconnect(session);
    return {.exitCode = 1, .error = "Authentication Failed"};
  }
  string error = string(ssh_get_error(session));
  sshHelper::disconnect(session);
  return {.exitCode = 1, .error = "Error while authenticating. \n" + error};
}

sshHelper::result<sftp_session> sshHelper::getsftpSession(ssh_session session) {
  sftp_session sftpSes = NULL;
  sftpSes = sftp_new(session);

  if (sftpSes == NULL) {
    return {.exitCode = 1, .error = "sftp = NULL"};
  }

  if (sftp_init(sftpSes) != 0) {
    sftp_free(sftpSes);
    return {.exitCode = 1, .error = "failed to init SFTP"};
  }

  return {.output = sftpSes, .exitCode = 0};
}

sshHelper::result<string> sshHelper::runCommandOn(ssh_session session,
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

  char buffer[2048];
  int usedBuffer;

  usedBuffer = 1;
  string stderrStr;
  stderrStr.reserve(4096);
  while (usedBuffer != 0) {
    // 1 = stderr, 0 = stdout
    usedBuffer = ssh_channel_read(channel, buffer, sizeof(buffer) - 1, 1);
    if (usedBuffer == 0)
      break;
    buffer[usedBuffer + 1] = '\0';
    stderrStr += string(buffer);
  }

  usedBuffer = 1;
  string stdoutStr;
  stdoutStr.reserve(4096);
  while (usedBuffer != 0) {
    // 1 = stdout, 0 = stdout
    usedBuffer = ssh_channel_read(channel, buffer, sizeof(buffer) - 1, 1);
    if (usedBuffer == 0)
      break;
    buffer[usedBuffer + 1] = '\0';
    stdoutStr += string(buffer);
  }

  ssh_channel_free(channel);
  return {.output = stdoutStr, .exitCode = 0, .error = stderrStr};
}

sshHelper::result<void> sshHelper::disconnect(ssh_session session) {
  ssh_disconnect(session);
  ssh_free(session);
  return {.exitCode = 0};
}
