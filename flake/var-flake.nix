{ inputs, home-manager }:

let
  var = {
    diamond = { 
      imports = [
        # CORE
        # boot
        ../core/boot/uefi-nix.nix
        ../core/boot/style-nix.nix

        # Hyprland
        ../core/hyprland/enable-nix.nix

        # Hyprlock
        ../core/hyprlock/enable-nix.nix

        # Hyprpanel
        ../core/hyprpanel/enable-nix.nix

        # Kitty
        ../core/kitty/enable-nix.nix
        ../core/kitty/tools-nix.nix

        # Networking
        ../core/networking/dhcp-nix.nix
    
        # PCmanFM
        ../core/pcmanfm/enable-nix.nix

        # Rofi
        ../core/rofi/enable-nix.nix
    
        # SDDM
        ../core/sddm/enable-nix.nix

        # Sound
        ../core/sound/sound-nix.nix

        # Other
        ../core/other/local-nix.nix       # Local settings
        ../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
        ../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
        ../core/other/user-nix.nix        # user  -  Adds a user
        ../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22 needed for deploy rs
        ../core/other/sudo-nix.nix        # sudo  -  Sudo settings
        ../core/other/x11-nix.nix         # x11  -  needed for Xwayland??
        ../core/other/journald-nix.nix    # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB

        # OPTIONAL
        # btop
        ../optional/btop/enable-nix.nix

        # Fast Fetch
        ../optional/fastfetch/enable-nix.nix         # Fastfetch  -  You got to show something in that cmd for your reddit posts

        # Firefox
        ../optional/firefox/enable-nix.nix

        # LapisLazuli
        ../optional/lapisLazuli/smb-nix.nix          # Lapius  -  My NAS! It's here cause I want it!
        ../optional/lapisLazuli/nfs-nix.nix          # Lapius  -  NAS

        # Strawberry
        ../optional/strawberry/enable-nix.nix        # Music player

        # VScode
        ../optional/vscode/enable-nix.nix

        # Other
        ../optional/other/alvr-nix.nix               # ALVR  -  For my vr nerds

        # My stuff
        ../hosts/diamond/other/programs-nix.nix
        ../hosts/diamond/hardware-configuration.nix  # hardware  -  your hardware settings
        ../hosts/diamond/stylix-nix.nix              # stylix  -  this repo expects stylix

        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        
      ];
      homeImports = [
        # CORE
        # Hyprland
        ../core/hyprland/bind-home.nix    # Keyboard bindings
        ../core/hyprland/settings-home.nix# Settings
        ../core/hyprland/style-home.nix   # Styles tweaks  -  (Most styling is handled by stylix)

        # Hyprlock
        ../core/hyprlock/style-home.nix   # Styles + What to display and where

        # Hyprpanel
        ../core/hyprpanel/style-home.nix

        # Kitty
        ../core/kitty/bind-home.nix       # Key binds
        ../core/kitty/style-home.nix      # Styles  -  You should be fine to get away with disabling this
        ../core/kitty/settings-home.nix   # Settings

        # PCmanFM
        # No home-manager files

        # Rofi
        ../core/rofi/style-home.nix       # Styles

        # SDDM
        # TODO : SDDM styles

        # Sound
        ../core/sound/sound-home.nix

        # Other
        ../core/other/xdg-mime-home.nix   # Sets default apps
        ../core/other/var-home.nix             # var  -  make var option for user config


        # OPTIONAL
        # You can comment and uncomment these as needed

        # btop
        ../optional/btop/style-home.nix

        # Fast Fetch
        ../optional/fastfetch/settings-home.nix  # Fastfetch  -  run on bash init

        # Firefox
        ../optional/firefox/settings-home.nix

        # Strawberry
        ../optional/strawberry/bind-home.nix     # Global Hotkeys for music player

        # VScode
        ../optional/vscode/settings-home.nix

        # Other
        # No home-manager files

        # My stuff
        ../hosts/diamond/other/monitor-settings-home.nix
        ../hosts/diamond/other/startup-home.nix

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

      bluetooth = true;

      screenshotFolder = "~/Pictures";
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
    };
    obsidian = {
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
        ../optional/services/pihole-nix.nix

        # My stuff
        ../hosts/obsidian/hardware-configuration.nix   # hardware  -  your hardware settings
        
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
    template = { 
      imports = [
        # CORE
        # boot
        #../core/boot/bios-nix.nix
        #../core/boot/uefi-nix.nix
        #../core/boot/style-nix.nix

        # Hyprland
        #../core/hyprland/enable-nix.nix

        # Hyprlock
        #../core/hyprlock/enable-nix.nix

        # Hyprpanel
        #../core/hyprpanel/enable-nix.nix

        # Kitty
        #../core/kitty/enable-nix.nix
        #../core/kitty/tools-nix.nix

        # Networking
        #../core/networking/dhcp-nix.nix
        #../core/networking/static-nix.nix
    
        # PCmanFM
        #../core/pcmanfm/enable-nix.nix

        # Rofi
        #../core/rofi/enable-nix.nix
    
        # SDDM
        #../core/sddm/enable-nix.nix

        # Sound
        #../core/sound/sound-nix.nix

        # Other
        #../core/other/local-nix.nix       # Local settings
        #../core/other/nix-nix.nix         # Nix settings  -  enable flakes, state nix version, etc
        #../core/other/programs-nix.nix    # Programs  -  Programs that are still needed. But dont need there own section
        #../core/other/user-nix.nix        # user  -  Adds a user
        #../core/other/ssh-nix.nix         # ssh  -  Enables ssh on port 22 needed for deploy rs
        #../core/other/sudo-nix.nix        # sudo  -  Sudo settings
        #../core/other/x11-nix.nix         # x11  -  needed for Xwayland??
        #../core/other/journald-nix.nix    # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB


        # OPTIONAL
        # You can comment and uncomment these as needed

        # btop
        #../optional/btop/enable-nix.nix

        # Fast Fetch
        #../optional/fastfetch/enable-nix.nix     # Fastfetch  -  You got to show something in that cmd for your reddit posts

        # Firefox
        #../optional/firefox/enable-nix.nix

        # LapisLazuli
        #../optional/lapisLazuli/smb-nix.nix      # Lapius  -  My NAS! It's here cause I want it!
        #../optional/lapisLazuli/nfs-nix.nix      # Lapius  -  NAS

        # Services
        #../optional/services/jellyfin-nix.nix
        #../optional/services/pihole-nix.nix

        # Strawberry
        #../optional/strawberry/enable-nix.nix    # Music player

        # VScode
        #../optional/vscode/enable-nix.nix

        # Other
        #../optional/other/alvr-nix.nix               # ALVR  -  For my vr nerds
        #../optional/other/print-nix.nix              # Print  -  How old are you?

        #inputs.stylix.nixosModules.stylix
        #home-manager.nixosModules.home-manager
        
      ];
      homeImports = [
        # CORE
        # Hyprland
        ../core/hyprland/bind-home.nix    # Keyboard bindings
        ../core/hyprland/settings-home.nix# Settings
        ../core/hyprland/style-home.nix   # Styles tweaks  -  (Most styling is handled by stylix)

        # Hyprlock
        ../core/hyprlock/style-home.nix   # Styles + What to display and where

        # Hyprpanel
        ../core/hyprpanel/style-home.nix

        # Kitty
        ../core/kitty/bind-home.nix       # Key binds
        ../core/kitty/style-home.nix      # Styles  -  You should be fine to get away with disabling this
        ../core/kitty/settings-home.nix   # Settings

        # PCmanFM
        # No home-manager files

        # Rofi
        ../core/rofi/style-home.nix       # Styles

        # SDDM
        # TODO : SDDM styles

        # Sound
        ../core/sound/sound-home.nix

        # Other
        ../core/other/home-home.nix       # Home-manager settings
        ../core/other/xdg-mime-home.nix   # Sets default apps
        ../core/other/var-home.nix             # var  -  make var option for user config


        # OPTIONAL
        # You can comment and uncomment these as needed

        # btop
        ../optional/btop/style-home.nix

        # Fast Fetch
        ../optional/fastfetch/settings-home.nix  # Fastfetch  -  run on bash init

        # Firefox
        ../optional/firefox/settings-home.nix

        # Strawberry
        ../optional/strawberry/bind-home.nix     # Global Hotkeys for music player

        # VScode
        ../optional/vscode/settings-home.nix

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

      
      static = { # only needed when using networking-static-nix.nix
        interface = "enp10s0";
        ipv4 = {
        address = "192.168.1.140";
        prefixLength = 24;
        };
        gatewayAddress = "192.168.1.1";

        nameservers = [ "192.168.1.249" ];
      };
      

      lapisLazuli = { 
        mount = "/home/reese/lapis_lazuli";
        share = "lapis_lazuli";
        credentials = "/etc/nixos/secrets/diamond-user-access";
      };

      bluetooth = true;

      # home manager vars
      screenshotFolder = "~/Pictures";
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
      
    };
  };
in
var