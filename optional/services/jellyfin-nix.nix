
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = false;
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}  
