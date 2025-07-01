# From: https://github.com/anotherhadi/nixy/tree/main
# Hyprpanel is the bar on top of the screen
# Display informations like workspaces, battery, wifi, ...
{ inputs, config, ... }:
{

  #imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;

    settings = {
      layout = {
        "bar.layouts" = {
          "*" = {
            "left" = [ "dashboard" "workspaces" "windowtitle" ];
            "middle" = [ "media" "cava" ];
            "right" = [
              "systray"
              "volume"
              "bluetooth"
              "battery"
              "network"
              "clock"
              "notifications"
            ];
          };
        };
      };

      theme.font.name = font;
      theme.font.size = fontSizeForHyprpanel;

      theme.bar.floating = floating;
      theme.bar.buttons.padding_x = "0.8rem";
      theme.bar.buttons.padding_y = "0.4rem";
    };
  };
}
