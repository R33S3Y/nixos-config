{ config, pkgs, specialArgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = specialArgs.var.${specialArgs.system}.monitor;
    };
  };
}
