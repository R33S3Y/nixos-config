{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "windowrulev2" = [
        #"nofullscreenrequest,class:^(steam_app_),title:^(?!SteamVR)"
        #"noinitialfullscreen,class:^(steam_app_),title:^(?!SteamVR)"
        "tile,class:^steam_app\d+$"
      ];
    };
  };
}
