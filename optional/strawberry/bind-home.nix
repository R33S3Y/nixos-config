{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$player" = "strawberry";

      exec-once = [
        "strawberry --play" # play my music
      ];
      bind = [
        # These map the deacated audio pause and play to strawberry
        ", XF86AudioPrev, exec, $player --previous"
        ", XF86AudioPlay, exec, $player --play-pause"
        ", XF86AudioNext, exec, $player --next"
      ];
    };
  };
}
