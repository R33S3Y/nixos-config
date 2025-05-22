
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

  systemd.tmpfiles.rules = [
    "d ${config.services.jellyfin.dataDir} 0755 ${config.services.jellyfin.users} users - -"
    "d ${config.services.jellyfin.configDir} 0755 ${config.services.jellyfin.users} users - -"
    "d ${config.services.jellyfin.logDir} 0755 ${config.services.jellyfin.users} users - -"
    "d ${config.services.jellyfin.cacheDir} 0755 ${config.services.jellyfin.users} users - -"
  ];
}
