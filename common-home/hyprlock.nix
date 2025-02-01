
{ config, lib, ... }:
let
  hexToDec = hex: (builtins.elemAt (builtins.match "[0-9a-fA-F]{2}" hex) 0) 
    |> (h: (builtins.fromJSON "[${builtins.toString (builtins.foldl' (acc: c: acc * 16 + (if c >= "a" then 10 + (builtins.stringToInt (builtins.toString (builtins.charToInt c) - builtins.charToInt "a")) else builtins.stringToInt c)) 0 (builtins.stringToList h))}]").0);

  hexToRgba = hex: alpha: let
    r = hexToDec (builtins.substring 1 2 hex);
    g = hexToDec (builtins.substring 3 2 hex);
    b = hexToDec (builtins.substring 5 2 hex);
  in "rgba(${toString r}, ${toString g}, ${toString b}, ${alpha})";
in {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        no_fade_in = false;
        disable_loading_bar = false;
      };

      auth = {
        method = "pam";
        prompt = "Password: ";  # Customize the prompt text if desired
      };

      # BACKGROUND
      background = {
        monitor = "";
        path = "${config.stylix.image}";
        blur_passes = 0;
        contrast = 0.8916;
        brightness = 0.7172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      label = [
        {
          # Day-Month-Date
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = hexToRgba "#${config.stylix.base16Scheme.base0D}" "1";
          font_size = 28;
          position = "0, 490";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = hexToRgba "#${config.stylix.base16Scheme.base0D}" "1";
          font_size = 160;
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "$USER";
          color = hexToRgba "#${config.stylix.base16Scheme.base0D}" "1";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = 18;
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
      ];

      # INPUT FIELD
      input-field = lib.mkForce {
        monitor = "";
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = hexToRgba "#${config.stylix.base16Scheme.base08}" "1";
        inner_color = hexToRgba "#${config.stylix.base16Scheme.base02}" "1";
        font_color = hexToRgba "#${config.stylix.base16Scheme.base0D}" "1";
        fade_on_empty = false;
        placeholder_text = "<i>Enter Password</i>";
        hide_input = false;
        position = "0, -250";
        halign = "center";
        valign = "center";
      };
    };
  };
}
