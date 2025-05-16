{ config, pkgs, ... }:
{
  imports = [

    # CORE
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
    # TODO : SDDM styles

    # Waybar
    ./waybar/style-home.nix     # Styles
    ./waybar/settings-home.nix  # Settings

    # Other
    ./other/home-home.nix       # Home-manager settings
    ./other/xdg-mime-home.nix   # Sets default apps
    ./other/var.nix             # var  -  make var option for user config


    # OPTIONAL
    # You can comment and uncomment these as needed

    # btop
    ../../optional/btop/style-home.nix

    # Fast Fetch
    ../../optional/fastfetch/settings-home.nix  # Fastfetch  -  run on bash init

    # Firefox
    ../../optional/firefox/settings-home.nix

    # Strawberry
    ../../optional/strawberry/bind-home.nix     # Global Hotkeys for music player

    # VScode
    ../../optional/vscode/settings-home.nix

    # Other
    # No home-manager files

    # My stuff
    ./other/monitor-settings-home.nix

  ];

  var.screenshotFolder = "~/Pictures";
  
}
