
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  fileSystems."/home/reese/lapus_lazuli" = {
    device = "//192.168.1.253/lapis_lazuli/";
    fsType = "cifs";
    options = [ "credentials=/etc/nas_credentials" "uid=reese" "gid=users" "iocharset=utf8" ];
  };
}