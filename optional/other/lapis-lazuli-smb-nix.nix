
{ config, pkgs, specialArgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."${specialArgs.var.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${specialArgs.var.lapisLazuli.share}";
    fsType = "cifs";
    options = [ "credentials=${specialArgs.var.lapisLazuli.credentials}" "uid=${specialArgs.var.username}" "gid=users" "iocharset=utf8" ];
  };
} 