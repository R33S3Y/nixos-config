
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alvr
    ffmpeg
    libva-utils 
  ];

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}