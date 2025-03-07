{ config, pkgs, ... }:
{
  imports = [

    # CORE
    # These imports will realisticly be needed
    ../../core/imports-home.nix
    ./stylix-home.nix # I should check if this is still needed


    # OPTIONAL
    # You can comment and uncomment these as needed

    # Fast Fetch
    ../../optional/fastfetch/settings-home.nix  # Fastfetch  -  run on bash init

    # Firefox
    ../../optional/firefox/settings-home.nix

    # VScode
    ../../optional/vscode/settings-home.nix

    # Other
    # No home-manager files

    # My stuff
    ./other/monitor-settings-home.nix

  ];
}
