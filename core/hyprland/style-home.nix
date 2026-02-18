{ config, pkgs, specialArgs, lib, ... }:
{ 

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux"; # Cursor name is the folder name of your choice in /nix/store/{{cursor Theme}}/share/icons
    package = pkgs.rose-pine-cursor;
    size = 32;

    gtk.enable = true;
    x11.enable = true;
    
    # Pointer is still not 100% consisant bettween apps, desktop and the phase of the moon. (when pixel peeping)
    # But it's close enough that I dont care.
    # That and I'm pretty sure that it's down to things like diffs with gtk and qt or X11 scaling or something like that

  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general  = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = "5";
        gaps_out = "10";
        border_size = specialArgs.themes.${specialArgs.theme}.borders.thickness;
        #col.active_border = "rgba(c18fb3ff) rgba(c18fb3ff) 45deg"
        #col.inactive_border = "rgba(57526cff)"

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        # allow_tearing = false
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = specialArgs.themes.${specialArgs.theme}.borders.rounding;
        
        blur = specialArgs.themes.${specialArgs.theme}.blur;

        shadow = {
          enabled = "true";
          range = "50";
          render_power = "10";
          #color = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}ff)";
        };

        active_opacity = "0.95";
        inactive_opacity = "0.9";
      };
    };
  };
}
