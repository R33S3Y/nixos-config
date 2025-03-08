{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      exec-once = [
        "sh -c 'sleep 1 && bluetoothctl connect C4:77:64:6C:56:95'" # connect to my Galaxy Buds FE
        "strawberry --play" # play my music
      ];

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        #"$mainMod, Q, exec, $terminal"
      ];
    };
  };
}
