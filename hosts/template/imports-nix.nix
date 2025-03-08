{ config, pkgs, ... }:
{
  imports = [

    # CORE
    # These imports will realisticly be needed
    ../../core/imports-nix.nix     # imports  -  imports all this repo's core stuff
    ./hardware-configuration.nix   # hardware  -  your hardware settings
    ./stylix-nix.nix               # stylix  -  this repo expects stylix
    ../../users/users-nix.nix      # user  -  You propaly want a user
    ../../users/local-nix.nix      # local  -  For setting local infomation like timezones


    # OPTIONAL
    # You can comment and uncomment these as needed

    # Fast Fetch
    ../../optional/fastfetch/enable-nix.nix     # Fastfetch  -  You got to show something in that cmd for your reddit posts

    # Firefox
    ../../optional/firefox/enable-nix.nix

    # Strawberry
    ../../optional/strawberry/enable-nix.nix    # Music player

    # VScode
    ../../optional/vscode/enable-nix.nix

    # Other
    ../../optional/other/alvr-nix.nix           # ALVR  -  For my vr nerds
    ../../optional/other/bluetooth-nix.nix      # Bluetooth  -  Enables bluetooth and installs blueman
    ../../optional/other/lapis-lazuli-nix.nix   # Lapius  -  My NAS! It's here cause I want it!
    #../../optional/other/print-nix.nix         # Print  -  How old are you?
    
  ];

  networking.hostName = "";
}
