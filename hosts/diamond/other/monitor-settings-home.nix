{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x0, 1"
        "DP-3, 2560x1440@165, 1920x-200, 2, transform, 3"
      ];
    };
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    settings = {
      X11 = {
        DisplayCommand = "/etc/sddm/Xsetup";
      };
    };
  };

  # Ensure the Xsetup script exists
  environment.etc."sddm/Xsetup".text = ''
    #!/bin/sh
    xrandr --output HDMI-A-1 --mode 1920x1080 --rate 60 --pos 0x0 --scale 1x1
    xrandr --output DP-3 --mode 2560x1440 --rate 165 --pos 1920x-200 --scale 2x2 --rotate left
  '';
}
