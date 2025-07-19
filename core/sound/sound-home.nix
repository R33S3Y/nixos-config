{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      exec-once = [
        "sh -c 'sleep 1 && bluetoothctl connect C4:77:64:6C:56:95'" # connect to my Galaxy Buds FE
      ];

      bind = [
        ", XF86AudioMute, exec, $player --volume 0"
        ", XF86AudioLowerVolume, exec, $player --volume-down"
        ", XF86AudioRaiseVolume, exec, $player --volume-up"
      ];
    };
  };
}
