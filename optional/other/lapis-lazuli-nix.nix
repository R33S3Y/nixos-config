
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."${config.var.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${config.var.lapisLazuli.share}";
    fsType = "cifs";
    options = [ "credentials=/etc/nas_credentials" "uid=${config.var.username}" "gid=users" "iocharset=utf8" ];
  };
}