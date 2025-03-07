{ config, pkgs, ... }:
{
  imports = [

    # Hyprland
    ./hyprland/enable-nix.nix

    # Hyprlock
    ./hyprlock/enable-nix.nix

    # Kitty
    ./kitty/enable-nix.nix

    # PCmanFM
    ./pcmanfm/enable-nix.nix

    # Rofi
    ./rofi/enable-nix.nix

    # SDDM
    ./sddm/enable-nix.nix

    # Waybar
    ./waybar/enable-nix.nix

    # Other
    ./other/boot-nix.nix        # Boot settings  -  Also contains plymouth settings
    ./other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
    ./other/networking-nix.nix  # Networking  -  internet is requirement for nixOS
    ./other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
    ./other/sound-nix.nix       # Sound  -  You like sound?
    ./other/x11-nix.nix         # x11  -  needed for Xwayland??
  ];
}
