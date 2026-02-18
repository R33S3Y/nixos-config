
{ config, pkgs, specialArgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."${specialArgs.hosts.${specialArgs.host}.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${specialArgs.hosts.${specialArgs.host}.lapisLazuli.share}";
    fsType = "cifs";
    options = [ "credentials=${specialArgs.hosts.${specialArgs.host}.lapisLazuli.credentials}" "uid=${specialArgs.users.${specialArgs.user}.name}" "gid=users" "iocharset=utf8" ];
  };
} 