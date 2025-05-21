
{ config, pkgs, ... }:

  services.jellyfin = {
    enable = true;
    #user = "reese";
    group = "users";

    dataDir = "/mnt/lapisLazuli/media";
    configDir = "/mnt/lapisLazuli/media/services/jellyfin/config";
    logDir = "/mnt/lapisLazuli/media/services/jellyfin/log";
    cacheDir = "/mnt/lapisLazuli/media/services/jellyfin/cache";
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}
