
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vencord
    discord
  ];
}