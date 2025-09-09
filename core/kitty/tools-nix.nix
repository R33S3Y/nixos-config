
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unixtools.netstat
  ];
}