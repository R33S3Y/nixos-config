{ inputs, home-manager }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux"; # or inherit system if passed from the flake
    config.allowUnfree = true;
  };
  diamond = { 
    imports = [
      # Imports must be at top
      inputs.stylix.nixosModules.stylix
      home-manager.nixosModules.home-manager
      # CORE
      # boot
      ../../core/boot/uefi-nix.nix
      ../../core/boot/style-nix.nix

      # Hyprland
      ../../core/hyprland/enable-nix.nix

      # Hyprlock
      ../../core/hyprlock/enable-nix.nix

      # Hyprpanel
      ../../core/hyprpanel/enable-nix.nix

      # Kitty
      ../../core/kitty/enable-nix.nix
      ../../core/kitty/tools-nix.nix

      # Networking
      ../../core/networking/dhcp-nix.nix
  
      # PCmanFM
      ../../core/pcmanfm/enable-nix.nix

      # qt
      ../../core/qt/enable-nix.nix

      # Rofi
      ../../core/rofi/enable-nix.nix
  
      # SDDM
      ../../core/sddm/enable-nix.nix

      # Sound
      ../../core/sound/sound-nix.nix

      # Other
      ../../core/other/local-nix.nix       # Local settings
      ../../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
      ../../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
      ../../core/other/user-nix.nix        # user  -  Adds a user
      ../../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22 needed for deploy rs
      ../../core/style/stylix-nix.nix      # stylix  -  this repo expects stylix
      ../../core/other/sudo-nix.nix        # sudo  -  Sudo settings
      ../../core/other/x11-nix.nix         # x11  -  needed for Xwayland??
      ../../core/other/journald-nix.nix    # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB

      # OPTIONAL
      # btop
      ../../optional/btop/enable-nix.nix

      # Fast Fetch
      ../../optional/fastfetch/enable-nix.nix         # Fastfetch  -  You got to show something in that cmd for your reddit posts

      # Firefox
      ../../optional/firefox/enable-nix.nix

      # LapisLazuli
      ../../optional/lapisLazuli/smb-nix.nix          # Lapius  -  My NAS! It's here cause I want it!
      ../../optional/lapisLazuli/nfs-nix.nix          # Lapius  -  NAS

      # steam
      ../../optional/steam/enable-nix.nix

      # Strawberry
      ../../optional/strawberry/enable-nix.nix        # Music player

      # VScode
      ../../optional/vscode/enable-nix.nix

      # Other
      ../../optional/other/alvr-nix.nix               # ALVR  -  For my vr nerds
      ../../optional/other/programs-nix.nix

      # My stuff
      ./hardware-configuration.nix  # hardware  -  your hardware settings
      
    ];
    homeImports = [
      # CORE
      # Hyprland
      ../../core/hyprland/bind-home.nix    # Keyboard bindings
      ../../core/hyprland/monitor-home.nix 
      ../../core/hyprland/settings-home.nix# Settings
      ../../core/hyprland/style-home.nix   # Styles tweaks  -  (Most styling is handled by stylix)

      # Hyprlock
      ../../core/hyprlock/style-home.nix   # Styles + What to display and where

      # Hyprpanel
      ../../core/hyprpanel/style-home.nix

      # Kitty
      ../../core/kitty/bind-home.nix       # Key binds
      ../../core/kitty/style-home.nix      # Styles  -  You should be fine to get away with disabling this
      ../../core/kitty/settings-home.nix   # Settings

      # PCmanFM
      # No home-manager files

      # qt
      ../../core/qt/style-home.nix

      # Rofi
      ../../core/rofi/style-home.nix       # Styles

      # SDDM
      # TODO : SDDM styles

      # Sound
      ../../core/sound/sound-home.nix

      # Other
      ../../core/other/xdgMime-home.nix   # Sets default apps


      # OPTIONAL
      # You can comment and uncomment these as needed

      # btop
      ../../optional/btop/style-home.nix

      # Fast Fetch
      ../../optional/fastfetch/settings-home.nix  # Fastfetch  -  run on bash init

      # Firefox
      ../../optional/firefox/settings-home.nix

      # steam
      ../../optional/steam/startup-home.nix

      # Strawberry
      ../../optional/strawberry/bind-home.nix     # Global Hotkeys for music player

      # VScode
      ../../optional/vscode/settings-home.nix

      # Other
      # No home-manager files

      # My stuff
      ../../hosts/diamond/other/startup-home.nix

    ];
    
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

    hostName = "diamond";

    lapisLazuli = { 
      mount = "/home/reese/lapis_lazuli";
      share = "lapis_lazuli";
      credentials = "/etc/nixos/secrets/diamond-user-access";
    };

    programs = with pkgs; [
      featherpad
      krita
      gimp3

      git
      vlc
      nano
      discord
      
      prismlauncher
      python314
      obsidian

      protonup-qt #needed for a vrchat fix

      bs-manager 

      r2modman
      orca-slicer
      openscad
      blender-hip

      obs-studio

      keymapp 

      kicad
      libreoffice-qt6-fresh

      qtcreator
      cmake
      gdb

      qbittorrent

      nfs-utils
      libnotify
    ];

    bluetooth = true;

    screenshotFolder = "~/Public";
    primaryDisplay =  "HDMI-A-1";

    microphone = {
      name = "Family 17h/19h/1ah HD Audio Controller Analog Stereo";
      bluetooth = {
        enable = false;
        id = "";
      };
    };
    speaker = {
      name = "Galaxy Buds FE";
      bluetooth = {
        enable = true;
        id = "C4:77:64:6C:56:95";
      };
    };
    monitor = [
      "HDMI-A-1, 1920x1080@60, 0x0, 1"
      "DP-3, 2560x1440@165, 1920x-200, 2, transform,3"
      "DP-2, 1920x1080@60, -960x375, 2"
    ];
  };
in
diamond