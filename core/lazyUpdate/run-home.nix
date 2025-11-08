
{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.exec-once = [
    ''
      notify-send "NixOS Auto Rebuild" "Starting rebuild for $HOSTNAME..."
      rm -rf /tmp/config_current
      mkdir -p /tmp/config_current
      git clone https://github.com/R33S3Y/nixos-config /tmp/config_current
      sudo nixos-rebuild switch --flake /tmp/config_current/#$HOSTNAME && \
        notify-send "NixOS Auto Rebuild" "Rebuild complete!" || \
        notify-send "NixOS Auto Rebuild" "Rebuild failed!"
    ''
  ];
}