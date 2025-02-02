
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
          color = "rgba(${config.stylix.base16Scheme.base04}ff)";
          font_size = 28;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(${config.stylix.base16Scheme.base06}ff)";
          font_size = 160;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "$USER";
          color = "rgba(${config.stylix.base16Scheme.base06}ff)";
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
      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(${config.stylix.base16Scheme.base06}ff) rgba(${config.stylix.base16Scheme.base04}ff) 0deg";
        check_color = "rgba(${config.stylix.base16Scheme.base08}ff) rgba(${config.stylix.base16Scheme.base09}ff) 0deg";
        fail_color = "rgba(${config.stylix.base16Scheme.base0D}ff) rgba(${config.stylix.base16Scheme.base0E}ff) 0deg";
        inner_color = "rgba(${config.stylix.base16Scheme.base02}40)";
        font_color = "rgba(${config.stylix.base16Scheme.base06}ff)";
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
