
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}