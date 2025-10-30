
{ config, pkgs, specialArgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."${specialArgs.var.${specialArgs.system}.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${specialArgs.var.${specialArgs.system}.lapisLazuli.share}";
    fsType = "cifs";
    options = [ "credentials=${specialArgs.var.${specialArgs.system}.lapisLazuli.credentials}" "uid=${specialArgs.var.${specialArgs.system}.username}" "gid=users" "iocharset=utf8" ];
  };
} 