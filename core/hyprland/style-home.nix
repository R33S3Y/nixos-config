{ config, pkgs, ... }:
{ 

  home.pointerCursor = {
    name = "phinger-cursors";
    package = pkgs.phinger-cursors;
    size = 24;
    #gtk.enable = true;
    hyprcursor.enable = true;
    #x11.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = [
        "waybar" # launch the topbar
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
          range = "8";
          render_power = "4";
          # color = "rgba(1a1a1aee)";
        };

        active_opacity = "1";
        inactive_opacity = "1";
      };
    };
  };
}
