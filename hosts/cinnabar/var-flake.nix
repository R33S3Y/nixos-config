{ inputs, home-manager, nur }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux"; # or inherit system if passed from the flake
    config.allowUnfree = true;
  };
  template = { 
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

      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../core/lazyUpdate/enable-nix.nix

      # Networking
      ../../core/networking/dhcp-nix.nix
  
      # PCmanFM
      ../../core/pcmanfm/enable-nix.nix

      # Rofi
      ../../core/rofi/enable-nix.nix
  
      # SDDM
      ../../core/sddm/enable-nix.nix

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
      # You can comment and uncomment these as needed

      # btop
      ../../optional/btop/enable-nix.nix

      # Fast Fetch
      ../../optional/fastfetch/enable-nix.nix     # Fastfetch  -  You got to show something in that cmd for your reddit posts

      # Firefox
      ../../optional/firefox/enable-nix.nix

      # LapisLazuli
      ../../optional/lapisLazuli/nfs-nix.nix      # Lapius  -  NAS

      # other
      ../../optional/other/programs-nix.nix

      # My stuff
      ./hardware-configuration.nix  # hardware  -  your hardware settings
      
    ];
    homeImports = [
      # CORE
      # Hyprland
      ../../core/hyprland/bind-home.nix    # Keyboard bindings
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

      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../core/lazyUpdate/run-home.nix

      # PCmanFM
      # No home-manager files

      # Rofi
      ../../core/rofi/style-home.nix       # Styles

      # SDDM
      # TODO : SDDM styles

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

    hostName = "cinnabar";

    programs = with pkgs; [
      handbrake
      libdvdcss
      ffmpeg-full
    ];

    # home manager vars
    screenshotFolder = "~/Pictures";
    primaryDisplay =  "Unknown-1";

    monitor = [
      "Unknown-1, 1920x1080@60, 0x0, 2"
    ];
    
  };
in
template