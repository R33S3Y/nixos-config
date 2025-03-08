{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$player" = "strawberry";

      exec-once = [
        "sh -c 'sleep 1 && bluetoothctl connect C4:77:64:6C:56:95'" # connect to my Galaxy Buds FE
        "strawberry --play" # play my music
      ];

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

        # These map the deacated audio pause and play as well as volume to strawberry
        ", XF86AudioPrev, exec, $player --previous"
        ", XF86AudioPlay, exec, $player --play-pause"
        ", XF86AudioNext, exec, $player --next"

        ", XF86AudioMute, exec, $player --volume 0"
        ", XF86AudioLowerVolume, exec, $player --volume-decrease-by 5"
        ", XF86AudioRasieVolume, exec, $player --volume-increase-by 5"
      ];
    };
  };
}
