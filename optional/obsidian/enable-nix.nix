
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obsidian
    
    rofi-obsidian
    xdg-utils
  ];
}
