{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@60, -1920x-1080, 1"
        "DP-3, 2560x1440@165, 0x0, 2, transform, 3"
      ];
    };
  };
}
