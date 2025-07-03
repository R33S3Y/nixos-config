{ config, pkgs, ... }:
{
  imports = [

    # CORE
    # Hyprland
    ../../core/hyprland/bind-home.nix    # Keyboard bindings
    ../../core/hyprland/settings-home.nix# Settings
    ../../core/hyprland/style-home.nix   # Styles tweaks  -  (Most styling is handled by stylix)

    # Hyprlock
    ../../core/hyprlock/style-home.nix   # Styles + What to display and where

    # Hyprpanel
    #../../core/hyprpanel/style-home.nix

    # Kitty
    ../../core/kitty/bind-home.nix       # Key binds
    ../../core/kitty/style-home.nix      # Styles  -  You should be fine to get away with disabling this
    ../../core/kitty/settings-home.nix   # Settings

    # PCmanFM
    # No home-manager files

    # Rofi
    ../../core/rofi/style-home.nix       # Styles

    # SDDM
    # TODO : SDDM styles

    # Waybar
    ../../core/waybar/style-home.nix     # Styles
    ../../core/waybar/settings-home.nix  # Settings

    # Other
    ../../core/other/home-home.nix       # Home-manager settings
    ../../core/other/xdg-mime-home.nix   # Sets default apps
    ../../core/other/var.nix             # var  -  make var option for user config


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
    ./other/startup-home.nix

  ];

  var = {
    screenshotFolder = "~/Pictures";
  };
}
