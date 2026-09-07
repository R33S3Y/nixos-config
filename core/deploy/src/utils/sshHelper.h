#include <cstddef>
#include <libssh/libssh.h>
#include <libssh/sftp.h>
#include <optional>
#include <string>
#include <vector>

using namespace std;
namespace sshHelper {
template <typename T> struct result {
  optional<T> output;
  int exitCode;
  optional<string> error;
};
template <> struct result<void> {
  int exitCode;
  optional<string> error;
};

result<ssh_session> connectTo(const string host, const string port,
                              const string user, const string password,
                              const string privateKey);
result<void> disconnect(ssh_session session);

/**
 * @brief Runs a command on the connected PC
 *
 * @param session   The ssh_session to use.
 *
 * @param command   The string command to run
 *
 * @return          On success, exitCode 0, stdout to output and stderr to
 *                  error. On failure, exitCode 1 and the error
 */
result<string> runCommandOn(ssh_session session, string command);
/**
 * @brief Gets the sftp_session together for use with libssh/sftp.h
 *
 * @param session   The ssh_session.
 *
 * @return          exitCode = 0, onSuccess
 */
result<sftp_session> getsftpSession(ssh_session session);
} // namespace sshHelper
