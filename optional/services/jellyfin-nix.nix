
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    configDir = "/mnt/lapisLazuli/media/services/jellyfin/config";
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}  
