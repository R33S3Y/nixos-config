
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vencord-web-extension
  ];
}