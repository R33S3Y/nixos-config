{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      misc = {
        "enable_anr_dialog" = "false";
      };
    };
  };
}
