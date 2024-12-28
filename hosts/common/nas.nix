
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];
  
  systemd.tmpfiles.rules = [
    # Ensure the directory exists with the correct ownership and permissions
    "d /home/reese/lapus_lazuli 0755 reese users -"
  ];

  fileSystems."/home/reese/lapus_lazuli" = {
    device = "//192.168.1.253/lapus_lazuli";
    fsType = "cifs";
    options = [ "credentials=/etc/nas_credentials" "uid=reese" "gid=users" "iocharset=utf8" ];
  };
}