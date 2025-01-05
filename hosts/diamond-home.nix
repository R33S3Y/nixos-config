{ config, pkgs, ... }:
{ 
  imports = [
    ./diamond/hyprland-monitor-home.nix
    ./diamond/bs-manager-home.nix
  ];
  stylix.enable = true;
  stylix.polarity = "dark";
}
