#include <cstddef>
#include <libssh/libssh.h>
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
result<void> transferFileTo(ssh_session session, string filePath,
                            string destPath);
result<string> runCommandOn(ssh_session session, string command);
result<void> disconnect(ssh_session session);

} // namespace sshHelper
