{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind = [
        ''
        CTRL, C, exec, if [[ hyprctl activewindow -j | jq -r .class == "kitty" ]]; then
          wtype -M ctrl -M shift c -m shift -m ctrl
        fi
        ''
      ];
    };
  };
}
