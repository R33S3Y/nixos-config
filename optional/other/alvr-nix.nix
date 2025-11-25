
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alvr
  ];

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}