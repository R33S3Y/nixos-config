
{ config, pkgs, specialArgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."${config.var.${specialArgs.system}.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${config.var.${specialArgs.system}.lapisLazuli.share}";
    fsType = "cifs";
    options = [ "credentials=${config.var.${specialArgs.system}.lapisLazuli.credentials}" "uid=${config.var.${specialArgs.system}.username}" "gid=users" "iocharset=utf8" ];
  };
} 