{ inputs, home-manager, nur, nix-minecraft }:

let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux"; # or inherit system if passed from the flake
    config.allowUnfree = true;
  };
  bort = { 
    imports = [
      # Nix modules
      inputs.nix-minecraft.nixosModules.minecraft-servers
      # CORE
      # boot
      ../../../core/boot/bios-nix.nix

      # Kitty
      ../../../core/kitty/tools-nix.nix

      # Networking
      ../../../core/networking/static-nix.nix

      # Other
      ../../../core/other/local-nix.nix       # Local settings
      ../../../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
      ../../../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
      ../../../core/other/user-nix.nix        # user  -  Adds a user
      ../../../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22 needed for deploy rs
      ../../../core/other/sudo-nix.nix        # sudo  -  Sudo settings
      ../../../core/other/x11-nix.nix         # x11  -  needed for Xwayland??
      ../../../core/other/journald-nix.nix    # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB


      # OPTIONAL
      # You can comment and uncomment these as needed

      # btop
      ../../../optional/btop/enable-nix.nix

      # Fast Fetch
      ../../../optional/fastfetch/enable-nix.nix     # Fastfetch  -  You got to show something in that cmd for your reddit posts

      # LapisLazuli
      ../../../optional/lapisLazuli/nfs-nix.nix      # Lapius  -  NAS

      # Services
      ../../../optional/services/minecraft/minecraft-nix.nix
      ../../../optional/services/minecraft/minecraftBackup-nix.nix
     
      # Other
      ../../../optional/other/programs-nix.nix           # Install all programs in the programs var

      # My stuff
      ./hardware-configuration.nix   # hardware  -  your hardware settings
    ];
    
    user = "reese";

    hostName = "bort";

    
    static = { # only needed when using networking-static-nix.nix
      interface = "ens18";
      ipv4 = {
      address = "192.168.1.246";
      prefixLength = 24;
      };
      gatewayAddress = "192.168.1.1";

      nameservers = [ "192.168.1.249" ];
    };
    

    programs = with pkgs; [
      
    ];
  };
in
bort