{ config, pkgs, specialArgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      exec-once = builtins.concatLists [
        (if specialArgs.var.${specialArgs.system}.microphone.bluetooth.enable then [
          "sh -c 'sleep 1 && bluetoothctl connect ${specialArgs.var.${specialArgs.system}.microphone.bluetooth.id}'"
        ] else [])
        (if specialArgs.var.${specialArgs.system}.speaker.bluetooth.enable then [
          "sh -c 'sleep 1 && bluetoothctl connect ${specialArgs.var.${specialArgs.system}.speaker.bluetooth.id}'"
        ] else [])
        [
          "sh -c 'sleep 2 && wpctl status | grep -oP '\d+(?=\. ${specialArgs.var.${specialArgs.system}.microphone.name})' | xargs wpctl set-default'"
          "sh -c 'sleep 2 && wpctl status | grep -oP '\d+(?=\. ${specialArgs.var.${specialArgs.system}.speaker.name})' | xargs wpctl set-default'"
        ]
      ];
        

      bind = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      ];
    };
  };
}
