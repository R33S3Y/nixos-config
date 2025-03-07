{ config, pkgs, ... }:
{
  imports = [

    # Hyprland
    ./hyprland/bind-home.nix    # Keyboard bindings
    ./hyprland/style-home.nix   # Styles tweaks  -  (Most styling is handled by stylix)

    # Hyprlock
    ./hyprlock/style-home.nix   # Styles + What to display and where

    # Kitty
    ./kitty/style-home.nix      # Styles  -  You should be fine to get away with disabling this
    ./kitty/settings-home.nix   # Settings

    # PCmanFM
    # No home-manager files

    # Rofi
    ./rofi/style-home.nix       # Styles

    # SDDM
    #  TODO : SDDM styles

    # Waybar
    ./waybar/style-home.nix     # Styles
    ./waybar/settings-home.nix  # Settings

    # Other
    ./other/home-home.nix       # Home-manager settings

  ];
}
