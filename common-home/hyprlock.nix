
{ config, lib, ... }:
let
  # Mapping hex characters to decimal values
  hexMap = {
    "0" = 0; "1" = 1; "2" = 2; "3" = 3; "4" = 4; "5" = 5; "6" = 6; "7" = 7; "8" = 8; "9" = 9;
    "a" = 10; "b" = 11; "c" = 12; "d" = 13; "e" = 14; "f" = 15;
    "A" = 10; "B" = 11; "C" = 12; "D" = 13; "E" = 14; "F" = 15;
  };

  # Convert a 2-character hex string to decimal
  hexToDec = hex: let
    high = hexMap.${builtins.substring 0 1 hex};
    low  = hexMap.${builtins.substring 1 1 hex};
  in (high * 16) + low;

  # Convert hex to RGBA
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
        blur_passes = 3;
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
          outline_thickness = 8;
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
        outline_thickness = 8;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "${hexToRgba "#${config.stylix.base16Scheme.base08}" "1"} ${hexToRgba "#${config.stylix.base16Scheme.base08}" "1"} 45deg";
        inner_color = hexToRgba "#${config.stylix.base16Scheme.base02}" "0.5";
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
