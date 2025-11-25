
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alvr
    libva1
  ];

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}