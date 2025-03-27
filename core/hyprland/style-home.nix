{ config, pkgs, ... }:
{ 

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux"; # Cursor name is the folder name of your choice in /nix/store/{{cursor Theme}}/share/icons
    package = pkgs.rose-pine-cursor;
    size = 24;

    gtk.enable = true;
    x11.enable = true;
    
    # Pointer is still not 100% consisant bettween apps, desktop and the phase of the moon. (when pixel peeping)
    # But it's close enough that I dont care.
    # That and I'm pretty sure that it's down to things like diffs with gtk and qt or X11 scaling or something like that

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
