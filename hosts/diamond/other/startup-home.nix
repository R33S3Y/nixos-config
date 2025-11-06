
{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.exec-once = [
    "steam -silent -no-browser"
  ];
  stylix.targets.qt.enable = true;
  
} 

