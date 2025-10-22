
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."${config.var.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${config.var.lapisLazuli.share}";
    fsType = "cifs";
    options = [ "credentials=${config.var.lapisLazuli.credentials}" "uid=${config.var.username}" "gid=users" "iocharset=utf8" ];
  };

  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/mnt/lapisLazuli" = {
    device = "lapisLazuli:/mnt/Pool 1/lapisLazuli";
    fsType = "nfs";
  };
} 