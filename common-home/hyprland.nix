{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "kitty";
      "$fileManager" = "spacedrive";
      "$menu" = ''rofi -modes "run,ssh" -show drun'';
      "$lock" = "${pkgs.hyprlock}/bin/hyprlock";

      "$mainMod" = "SUPER";

      exec-once = [
        "waybar"
      ];
      env = [
        # needed for space drive
        # was copyed over from rofi env EG: lanuch kitty via rofi then run: env > /tmp/env_rofi.txt
        # to get the updated version of this
        "XDG_DATA_DIRS,/nix/store/a6qb8whj2ad7lizr0ghag2a63nss39f7-hicolor-icon-theme-0.18/share:/nix/store/zisyg7919dsx2r28zhggdab4r6xmb257-rofi-1.7.5+wayland3/share:/nix/store/l8x0x87qb2y5j71ff42nbnsqd6jpgdz8-gsettings-desktop-schemas-47.1/share/gsettings-schemas/gsettings-desktop-schemas-47.1:/nix/store/0whdwl2a2jcykffs7p60h32khzlp2ksd-gtk+3-3.24.43/share/gsettings-schemas/gtk+3-3.24.43:/nix/store/hxlyzfdn7fawvd8ahg9w63g5sfw69qhv-desktops/share:/home/reese/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/home/reese/.nix-profile/share:/nix/profile/share:/home/reese/.local/state/nix/profile/share:/etc/profiles/per-user/reese/share:/nix/var/nix/profiles/default/share:/run/current-system/sw/share"
      ];

      general  = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = "5";
        gaps_out = "20";
        border_size = "2";
        #col.active_border = "rgba(c18fb3ff) rgba(c18fb3ff) 45deg"
        #col.inactive_border = "rgba(57526cff)"

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        # allow_tearing = false
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = "10";
        
        blur = {
          enabled = "true";
          size = "7";
          passes = "1";
        };

        shadow = {
          enabled = "true";
          range = "4";
          render_power = "3";
          # color = "rgba(1a1a1aee)";
        };

        active_opacity = "1";
        inactive_opacity = "0.8";
      };

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, L, exec, hyprlock,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, Z, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # Screenshot a window
        "$mainMod SHIFT, PRINT, exec, hyprshot -m window"

        # Screenshot a monitor
        ", PRINT, exec, hyprshot -m output"

        # Screenshot a region
        "$mainMod, PRINT, exec, hyprshot -m region"

        # color picker
        "$mainMod CTRL, PRINT, exec, hyprpicker -a"

      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
