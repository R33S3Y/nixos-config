{ config, pkgs, specialArgs, lib, ... }:
let 
  theme = specialArgs.themes.${specialArgs.theme};
in
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

        gaps_in = theme.borders.padding.inner;
        gaps_out = theme.borders.padding.outer;
        border_size = theme.borders.thickness;

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        # allow_tearing = false
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = theme.borders.rounding;
        
        blur = theme.blur;

        shadow = theme.shadow;

        active_opacity = theme.opacity.active;
        inactive_opacity = theme.opacity.inactive;
      };
    };
  };
}
