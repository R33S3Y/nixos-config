
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fahclient
  ];

   
}