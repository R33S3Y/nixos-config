
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
  };
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}  
