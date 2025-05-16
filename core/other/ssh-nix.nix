
{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ config.var.username ];
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };
}