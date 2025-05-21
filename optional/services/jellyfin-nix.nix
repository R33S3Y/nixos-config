
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;

    dataDir = "/mnt/lapisLazuli/media";
    configDir = "/mnt/lapisLazuli/media/services/jellyfin/config";
    logDir = "/mnt/lapisLazuli/media/services/jellyfin/log";
    cacheDir = "/mnt/lapisLazuli/media/services/jellyfin/cache";
  };
}
