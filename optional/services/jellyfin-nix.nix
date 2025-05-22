
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    user = "reese";
    group = "users";

    dataDir = "/home/reese/services/jellyfin/";
    configDir = "/mnt/lapisLazuli/media/services/jellyfin/config";
    logDir = "/mnt/lapisLazuli/media/services/jellyfin/log";
    cacheDir = "/home/reese/services/jellyfin/cache";
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}
