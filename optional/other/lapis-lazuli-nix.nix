
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
  
  systemd.tmpfiles.rules = [
    "d ${config.var.lapisLazuli.mount} 0755 ${config.var.username} users - -"
  ];
} 