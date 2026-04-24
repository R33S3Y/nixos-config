{
  config,
  pkgs,
  config,
  ...
}:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [
        config.system.users.${config.system.user}.name
        "rebuild"
      ];
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };
  programs.ssh.startAgent = true;
}
