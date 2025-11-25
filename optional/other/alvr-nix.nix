
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alvr
    libva
  ];

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}