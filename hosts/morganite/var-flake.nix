{ inputs, home-manager }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux"; # or inherit system if passed from the flake
    config.allowUnfree = true;
  };
  morganite = {
    imports = [
      # CORE
      # boot
      ../core/boot/bios-nix.nix

      # Kitty
      ../core/kitty/tools-nix.nix

      # Networking
      ../core/networking/static-nix.nix

      # Other
      ../core/other/local-nix.nix       # Local settings
      ../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
      ../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
      ../core/other/user-nix.nix        # user  -  Adds a user
      ../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22
      ../core/other/sudo-nix.nix        # sudo  -  Sudo settings
      ../core/other/journald-nix.nix    # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB

      # OPTIONAL
      # btop
      ../optional/btop/enable-nix.nix

      # Fast Fetch
      ../optional/fastfetch/enable-nix.nix     # Fastfetch  -  You got to show something in that cmd for your reddit posts

      # Services
      ../optional/services/jellyfin-nix.nix

      # lapisLazuli
      ../optional/lapisLazuli/nfs-nix.nix             # Lapius  -  NAS

      # My stuff
      ../hosts/morganite/hardware-configuration.nix   # hardware  -  your hardware settings
      
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

    hostName = "morganite";

    static = { # only needed when using networking-static-nix.nix
      interface = "ens18";
      ipv4 = {
        address = "192.168.1.248";
        prefixLength = 24;
      };
      gatewayAddress = "192.168.1.1";

      nameservers = [ "192.168.1.249" ];
    };
  };
in
morganite