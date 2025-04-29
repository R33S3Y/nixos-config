{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "windowrule" = [
        # "tile,class:^steam_app_\d+$"
      ];
    };
  };
}
