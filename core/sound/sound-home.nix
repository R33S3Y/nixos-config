{
  config,
  pkgs,
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      # this is broken
      exec-once = builtins.concatLists [
        (
          if config.system.hosts.${config.system.host}.microphone.bluetooth.enable then
            [
              "sh -c 'sleep 1 && bluetoothctl connect ${
                config.system.hosts.${config.system.host}.microphone.bluetooth.id
              }'"
            ]
          else
            [ ]
        )
        (
          if config.system.hosts.${config.system.host}.speaker.bluetooth.enable then
            [
              "sh -c 'sleep 1 && bluetoothctl connect ${
                config.system.hosts.${config.system.host}.speaker.bluetooth.id
              }'"
            ]
          else
            [ ]
        )
        [
          "getDeviceId --source '${
            config.system.hosts.${config.system.host}.microphone.name
          }' | xarg -I {} wpctl set-volume {} ${config.system.hosts.${config.system.host}.speaker.volume}"
          "getDeviceId --sink '${
            config.system.hosts.${config.system.host}.speaker.name
          }' | xarg -I {} wpctl set-volume {} ${config.system.hosts.${config.system.host}.speaker.volume}"
          "getDeviceId --source '${
            config.system.hosts.${config.system.host}.microphone.name
          }' | xargs wpctl set-default"
          "getDeviceId --sink '${
            config.system.hosts.${config.system.host}.speaker.name
          }' | xargs wpctl set-default"
        ]
      ];

      bind = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
