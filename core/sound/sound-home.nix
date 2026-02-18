{ config, pkgs, specialArgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      # this is broken
      exec-once = builtins.concatLists [
        (if specialArgs.hosts.${specialArgs.host}.microphone.bluetooth.enable then [
          "sh -c 'sleep 1 && bluetoothctl connect ${specialArgs.hosts.${specialArgs.host}.microphone.bluetooth.id}'"
        ] else [])
        (if specialArgs.hosts.${specialArgs.host}.speaker.bluetooth.enable then [
          "sh -c 'sleep 1 && bluetoothctl connect ${specialArgs.hosts.${specialArgs.host}.speaker.bluetooth.id}'"
        ] else [])
        [
          "getDeviceId --source '${specialArgs.hosts.${specialArgs.host}.microphone.name}' | xarg -I {} wpctl set-volume {} ${specialArgs.hosts.${specialArgs.host}.speaker.volume}"
          "getDeviceId --sink '${specialArgs.hosts.${specialArgs.host}.speaker.name}' | xarg -I {} wpctl set-volume {} ${specialArgs.hosts.${specialArgs.host}.speaker.volume}"
          "getDeviceId --source '${specialArgs.hosts.${specialArgs.host}.microphone.name}' | xargs wpctl set-default"
          "getDeviceId --sink '${specialArgs.hosts.${specialArgs.host}.speaker.name}' | xargs wpctl set-default"
        ]
      ];
        

      bind = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
