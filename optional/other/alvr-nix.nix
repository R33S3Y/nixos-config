
{ config, pkgs, ... }:

{
  programs.alvr.enable = true;

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}