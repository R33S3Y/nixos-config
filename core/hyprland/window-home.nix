{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "windowrulev2" = [
        #"nofullscreenrequest,class:^(steam_app_),title:^(?!SteamVR)"
        #"noinitialfullscreen,class:^(steam_app_),title:^(?!SteamVR)"
        "unset, class:^(steam_app_[0-9]+)$"
        "nofullscreen, class:^(steam_app_[0-9]+)$"
      ];
    };
  };
}
