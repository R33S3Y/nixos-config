{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "windowrule" = [
        #"nofullscreenrequest,class:^(steam_app_),title:^(?!SteamVR)"
        #"noinitialfullscreen,class:^(steam_app_),title:^(?!SteamVR)"
        "tile,class:^steam_app_\d+$"
      ];
    };
  };
}
