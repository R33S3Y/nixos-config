
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;

    #user = "reese";
    group = "users";

    dataDir = "/var/lib/jellyfin";
    cacheDir = "/var/cache/jellyfin";

    logDir = "/mnt/lapisLazuli/media/services/jellyfin/log";  
    configDir = "/mnt/lapisLazuli/media/services/jellyfin/config";
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}  
