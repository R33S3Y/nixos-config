
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alvr
    libva
    libva-utils
  ];

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}