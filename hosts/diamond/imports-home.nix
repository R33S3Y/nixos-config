{ config, pkgs, ... }:
{
  imports = [

    # CORE
    # These imports will realisticly be needed
    ../../core/imports-home.nix


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
}
