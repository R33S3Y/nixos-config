{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x0, 1"
        "DP-3, 2560x1440@165, 1920x-200, 2, transform,3, cm,hdr, bitdepth,10, sdrbrightness,1.4, sdrsaturation,1.2"
        "DP-2, 1920x1080@60, -960x375, 2"
      ];
    };
  };
}
