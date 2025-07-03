# From: https://github.com/anotherhadi/nixy/tree/main
# Hyprpanel is the bar on top of the screen
# Display informations like workspaces, battery, wifi, ...
{ inputs, config, ... }:
{

  #imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprpanel"
  ];
}
