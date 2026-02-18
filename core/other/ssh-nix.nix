
{ config, pkgs, specialArgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ 
        specialArgs.users.${specialArgs.user}.name
        "rebuild"
      ];
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };
  programs.ssh.startAgent = true;
}