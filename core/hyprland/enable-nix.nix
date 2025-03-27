
{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    hyprcursor
    rose-pine-hyprcursor
    rose-pine-cursor
    phinger-cursors
  ];
}
