{ system, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      # this is broken
      exec-once = builtins.concatLists [
        (
          if system.hosts.${system.host}.microphone.bluetooth.enable then
            [
              "sh -c 'sleep 1 && bluetoothctl connect ${
                system.hosts.${system.host}.microphone.bluetooth.id
              }'"
            ]
          else
            [ ]
        )
        (
          if system.hosts.${system.host}.speaker.bluetooth.enable then
            [
              "sh -c 'sleep 1 && bluetoothctl connect ${
                system.hosts.${system.host}.speaker.bluetooth.id
              }'"
            ]
          else
            [ ]
        )
        [
          "getDeviceId --source '${
            system.hosts.${system.host}.microphone.name
          }' | xarg -I {} wpctl set-volume {} ${system.hosts.${system.host}.speaker.volume}"
          "getDeviceId --sink '${
            system.hosts.${system.host}.speaker.name
          }' | xarg -I {} wpctl set-volume {} ${system.hosts.${system.host}.speaker.volume}"
          "getDeviceId --source '${
            system.hosts.${system.host}.microphone.name
          }' | xargs wpctl set-default"
          "getDeviceId --sink '${
            system.hosts.${system.host}.speaker.name
          }' | xargs wpctl set-default"
        ]
      ];

      bind = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
