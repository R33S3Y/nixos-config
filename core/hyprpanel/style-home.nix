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
            "left" = [  ];
            "middle" = [ "media" "cava" ];
            "right" = [
              "dashboard" "workspaces" "windowtitle"
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
    };
  };
}
