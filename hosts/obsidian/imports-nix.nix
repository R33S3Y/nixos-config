{ config, pkgs, ... }:
{
  imports = [

    # CORE
    # boot
    ../../core/boot/bios-nix.nix
    #../../core/boot/uefi-nix.nix
    #../../core/boot/style-nix.nix
    
    # Hyprland
    #../../core/hyprland/enable-nix.nix

    # Hyprlock
    #../../core/hyprlock/enable-nix.nix

    # Hyprpanel
    #../../core/hyprpanel/enable-nix.nix

    # Kitty
    #../../core/kitty/enable-nix.nix
    ../../core/kitty/tools-nix.nix

    # Networking
    #../../core/networking/dhcp-nix.nix
    ../../core/networking/static-nix.nix

    # PCmanFM
    #../../core/pcmanfm/enable-nix.nix

    # Rofi
    #../../core/rofi/enable-nix.nix

    # SDDM
    #../../core/sddm/enable-nix.nix

    # Sound
    #../../core/sound/sound-nix.nix

    # Waybar
    #../../core/waybar/enable-nix.nix

    # Other
    ../../core/other/local-nix.nix       # Local settings
    ../../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
    ../../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
    #../../core/other/sound-nix.nix      # Sound  -  You like sound?
    ../../core/other/user-nix.nix        # user  -  Adds a user
    ../../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22
    ../../core/other/sudo-nix.nix        # sudo  -  Sudo settings for deploy rs
    #../../core/other/x11-nix.nix        # x11  -  needed for Xwayland??
    ../../core/other/var.nix             # var  -  make var option for user config

 
    # OPTIONAL
    # You can comment and uncomment these as needed

    # btop
    ../../optional/btop/enable-nix.nix

    # Fast Fetch
    ../../optional/fastfetch/enable-nix.nix     # Fastfetch  -  You got to show something in that cmd for your reddit posts

    # Firefox
    #../../optional/firefox/enable-nix.nix

    # Services
    #../../optional/services/jellyfin-nix.nix
    ../../optional/services/pihole-nix.nix

    # Strawberry
    #../../optional/strawberry/enable-nix.nix    # Music player

    # VScode
    #../../optional/vscode/enable-nix.nix

    # Other
    #../../optional/other/alvr-nix.nix           # ALVR  -  For my vr nerds
    #../../optional/other/bluetooth-nix.nix      # Bluetooth  -  Enables bluetooth and installs blueman
    #../../optional/other/lapis-lazuli-nix.nix   # Lapius  -  My NAS! It's here cause I want it!
    #../../optional/other/print-nix.nix          # Print  -  How old are you?


    # My stuff
    ./hardware-configuration.nix   # hardware  -  your hardware settings
    
  ];

  var = {

    username = "reese";

    timeZone = "Pacific/Auckland";

    defaultLocale = "en_NZ.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_NZ.UTF-8";
      LC_IDENTIFICATION = "en_NZ.UTF-8";
      LC_MEASUREMENT = "en_NZ.UTF-8";
      LC_MONETARY = "en_NZ.UTF-8";
      LC_NAME = "en_NZ.UTF-8";
      LC_NUMERIC = "en_NZ.UTF-8";
      LC_PAPER = "en_NZ.UTF-8";
      LC_TELEPHONE = "en_NZ.UTF-8";
      LC_TIME = "en_NZ.UTF-8";
    };

    hostName = "obsidian";

    static = { # only needed when using networking-static-nix.nix
      interface = "ens18";
      ipv4 = {
        address = "192.168.1.249";
        prefixLength = 24;
      };
      gatewayAddress = "192.168.1.1";

      nameservers = [ "192.168.1.249" ];
    };
  };
}
