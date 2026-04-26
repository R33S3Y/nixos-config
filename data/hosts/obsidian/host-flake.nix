{ inputs, home-manager }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux"; # or inherit system if passed from the flake
    config.allowUnfree = true;
  };
  obsidian = {
    imports = [
      # Nix modules
      inputs.stylix.nixosModules.stylix
      home-manager.nixosModules.home-manager

      # CORE

      # boot
      ../../../core/boot/bios-nix.nix
      #../../../core/boot/uefi-nix.nix
      ../../../core/boot/style-nix.nix
      # btop
      ../../../core/btop/enable-nix.nix
      # Fast Fetch
      ../../../core/fastfetch/enable-nix.nix # Fastfetch  -  You got to show something in that cmd for your reddit posts
      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../../core/lazyUpdate/enable-nix.nix
      # Networking
      #../../../core/networking/dhcp-nix.nix
      ../../../core/networking/static-nix.nix
      # PCmanFM
      ../../../desktop/pcmanfm/enable-nix.nix
      # Rofi
      ../../../core/rofi/enable-nix.nix
      # Style
      ../../../core/style/stylix-nix.nix # stylix  -  this repo expects stylix
      # Other
      ../../../core/other/cmd-nix.nix # CMD  -  Programs that are still needed. But don't need there own section
      ../../../core/other/home-nix.nix # home
      ../../../core/other/journald-nix.nix # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB
      ../../../core/other/local-nix.nix # Local settings
      ../../../core/other/nix-nix.nix # Nix settings  -  enable flakes, state nix version, etc
      ../../../core/other/programs-nix.nix # Install all programs in the programs var
      ../../../core/other/ssh-nix.nix # ssh  -  Enables ssh on port 22 needed for deploy rs
      ../../../core/other/sudo-nix.nix # sudo  -  Sudo settings
      ../../../core/other/user-nix.nix # user  -  Adds a user

      # Services

      # (servers)
      ../../../services/pihole/pihole-nix.nix

      # My stuff
      ./hardware-configuration.nix # hardware  -  your hardware settings
    ];
    homeImports = [
      # CORE

      # btop
      ../../../core/btop/style-home.nix
      # Fast Fetch
      ../../../core/fastfetch/settings-home.nix # Fastfetch  -  run on bash init
      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../../core/lazyUpdate/run-home.nix
      # Rofi
      ../../../core/rofi/style-home.nix # Styles
      # Other
      ../../../core/other/xdgMime-home.nix # Sets default apps
    ];

    user = "reese";

    hostName = "obsidian";

    static = {
      enable = true;

      interface = "ens18";
      ipv4 = {
        address = "192.168.1.249";
        prefixLength = 24;
      };
      gatewayAddress = "192.168.1.1";

      nameservers = [ "192.168.1.249" ];
    };
  };

in
obsidian
