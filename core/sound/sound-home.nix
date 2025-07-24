{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      exec-once = builtins.concatLists [
        (if config.var.microphone.bluetooth.enable then [
          "sh -c 'sleep 1 && bluetoothctl connect ${config.var.microphone.bluetooth.id}'"
        ] else [])
        (if config.var.speaker.bluetooth.enable then [
          "sh -c 'sleep 1 && bluetoothctl connect ${config.var.speaker.bluetooth.id}'"
        ] else [])
        [
          "sh -c 'sleep 2 && wpctl status | grep -oP '\d+(?=\. ${config.var.microphone.name})' | xargs wpctl set-default'"
          "sh -c 'sleep 2 && wpctl status | grep -oP '\d+(?=\. ${config.var.speaker.name})' | xargs wpctl set-default'"
        ]
      ];
        

      bind = [
        ", XF86AudioMute, exec, $player --volume 0"
        ", XF86AudioLowerVolume, exec, $player --volume-down"
        ", XF86AudioRaiseVolume, exec, $player --volume-up"
      ];
    };
  };
}
