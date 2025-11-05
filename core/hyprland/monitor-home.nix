{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = specialArgs.var.${specialArgs.system}.monitor;
    };
  };
}
