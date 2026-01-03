{ inputs, home-manager, nur }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux"; # or inherit system if passed from the flake
    config.allowUnfree = true;
  };
  diamond = { 
    imports = [
      # Nix modules
      inputs.stylix.nixosModules.stylix
      home-manager.nixosModules.home-manager
      nur.modules.nixos.default
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

      # Rofi
      ../../core/rofi/enable-nix.nix
  
      # SDDM
      ../../core/sddm/enable-nix.nix

      # Sound
      ../../core/sound/sound-nix.nix

      # Other
      ../../core/other/home-nix.nix        # home
      ../../core/other/journald-nix.nix    # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB
      ../../core/other/local-nix.nix       # Local settings
      ../../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
      ../../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
      ../../core/other/user-nix.nix        # user  -  Adds a user
      ../../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22 needed for deploy rs
      ../../core/style/stylix-nix.nix      # stylix  -  this repo expects stylix
      ../../core/other/sudo-nix.nix        # sudo  -  Sudo settings
      ../../core/other/x11-nix.nix         # x11  -  needed for Xwayland??
      

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

      # obsidian
      ../../optional/obsidian/enable-nix.nix

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

      # obsidian
      ../../optional/obsidian/settings-home.nix

      # steam
      ../../optional/steam/startup-home.nix

      # Strawberry
      ../../optional/strawberry/bind-home.nix     # Global Hotkeys for music player

      # VScode
      ../../optional/vscode/settings-home.nix

      # Other
      # No home-manager files

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
      git-lfs
      vlc
      nano
      discord
      
      prismlauncher
      python314

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

      keepassxc
    ];

    bluetooth = true;

    screenshotFolder = "~/Pictures";
    primaryDisplay =  "HDMI-A-1";

    microphone = {
      # use wpctl status to get device names
      name = "Blue Microphones Analog Stereo";
      bluetooth = {
        enable = false;
        id = ""; # bluetoothctl devices
      };
    };
    speaker = {
      name = "Baseus Inspire XC1";
      bluetooth = {
        enable = true;
        id = "54:84:50:67:C9:A2"; # bluetoothctl devices
      };
    };
    monitor = [
      "HDMI-A-1, 3840x2160@60, 0x0, 1"
      "DP-3, 2560x1440@165, 3840x0, 1.066667, transform,3"
      "DP-2, 1920x1080@60, -1920x975, 1"
    ];
  };
in
diamond