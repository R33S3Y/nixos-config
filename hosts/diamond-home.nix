{ config, pkgs, ... }:
{ 
  imports = [
    ./diamond/hyprland-monitor-home.nix
  ];
  stylix.enable = true;
  stylix.polarity = "dark";
}
