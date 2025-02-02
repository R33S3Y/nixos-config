
{ config, lib, ... }:
{
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
          color = "rgba(${config.stylix.base16Scheme.base0D}ff)";
          font_size = 28;
          position = "0, 490";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(${config.stylix.base16Scheme.base0D}ff)";
          font_size = 160;
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "$USER";
          color = "rgba(${config.stylix.base16Scheme.base0D}ff)";
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
        outer_color = "rgba(${config.stylix.base16Scheme.base0D}ff) rgba(${config.stylix.base16Scheme.base0D}ff) 45deg";
        inner_color = "rgba(${config.stylix.base16Scheme.base0D}ff)";
        font_color = "rgba(${config.stylix.base16Scheme.base0D}ff)";
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
