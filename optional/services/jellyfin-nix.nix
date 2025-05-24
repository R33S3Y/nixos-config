
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;

    user = "reese";
    group = "users";

    dataDir = "/var/lib/jellyfin";
    cacheDir = "/var/cache/jellyfin";

    logDir = "/var/lib/jellyfin/log";  
    configDir = "/var/lib/jellyfin/config";
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}  
