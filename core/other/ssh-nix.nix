
{ config, pkgs, specialArgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ 
        specialArgs.hosts.${specialArgs.host}.username
        "rebuild"
      ];
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };
  programs.ssh.startAgent = true;
}