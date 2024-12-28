
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."/mnt/lapus_lazuli" = {
    device = "//192.168.1.253/lapus_lazuli";
    fsType = "cifs";
    options = [ "credentials=/etc/nas_credentials" "uid=reese" "gid=users" "iocharset=utf8" ];
  };
}