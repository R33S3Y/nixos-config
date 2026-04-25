{
  inputs,
  home-manager,
  nur,
  nix-minecraft,
}:

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
      inputs.nix-minecraft.nixosModules.minecraft-servers

      # CORE

      # boot
      ../../../core/boot/bios-nix.nix
      ../../../core/boot/uefi-nix.nix
      ../../../core/boot/style-nix.nix
      # btop
      ../../../core/btop/enable-nix.nix
      # Fast Fetch
      ../../../core/fastfetch/enable-nix.nix # Fastfetch  -  You got to show something in that cmd for your reddit posts
      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../../core/lazyUpdate/enable-nix.nix
      # Networking
      ../../../core/networking/dhcp-nix.nix
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
      ../../../core/other/x11-nix.nix # x11  -  needed for Xwayland??

      # Desktop
      # You can comment and uncomment these as needed

      # Firefox
      ../../../desktop/firefox/enable-nix.nix
      # Hyprland
      ../../../desktop/hyprland/enable-nix.nix
      # Hyprlock
      ../../../desktop/hyprlock/enable-nix.nix
      # Hyprpanel
      ../../../desktop/hyprpanel/enable-nix.nix
      # Kitty
      ../../../desktop/kitty/enable-nix.nix
      # nixcord
      ../../../desktop/nixcord/enable-nix.nix
      # obsidian
      ../../../desktop/obsidian/enable-nix.nix
      # SDDM
      ../../../desktop/sddm/enable-nix.nix
      # Sound
      ../../../desktop/sound/sound-nix.nix
      # steam
      ../../../desktop/steam/enable-nix.nix
      # Strawberry
      ../../../desktop/strawberry/enable-nix.nix # Music player
      # VScode
      ../../../desktop/vscode/enable-nix.nix
      # Other
      ../../../desktop/other/alvr-nix.nix # ALVR  -  For my vr nerds
      ../../../desktop/other/print-nix.nix # Print  -  How old are you?

      # Services

      # (servers)
      ../../../services/jellyfin/jellyfin-nix.nix
      ../../../services/minecraft/minecraft-nix.nix
      ../../../services/minecraft/minecraftBackup-nix.nix
      ../../../services/pihole/pihole-nix.nix

      # OTHER

      # LapisLazuli
      ../../../other/lapisLazuli/home-nix.nix # Lapis  -  Mount NAS to home
      ../../../other/lapisLazuli/smb-nix.nix # Lapis  -  My NAS! It's here cause I want it!
      ../../../other/lapisLazuli/nfs-nix.nix # Lapis  -  NAS
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
      # Sound
      ../../../desktop/sound/sound-home.nix
      # Other
      ../../../core/other/xdgMime-home.nix # Sets default apps

      # DESKTOP
      # You can comment and uncomment these as needed

      # Firefox
      ../../../desktop/firefox/settings-home.nix
      # Hyprland
      ../../../desktop/hyprland/bind-home.nix # Keyboard bindings
      ../../../desktop/hyprland/monitor-home.nix # Monitor settings
      ../../../desktop/hyprland/settings-home.nix # Settings
      ../../../desktop/hyprland/style-home.nix # Styles tweaks  -  (Most styling is handled by stylix)
      # Hyprlock
      ../../../desktop/hyprlock/style-home.nix # Styles + What to display and where
      # Hyprpanel
      ../../../desktop/hyprpanel/style-home.nix
      # Kitty
      ../../../desktop/kitty/bind-home.nix # Key binds
      ../../../desktop/kitty/style-home.nix # Styles  -  You should be fine to get away with disabling this
      ../../../desktop/kitty/settings-home.nix # Settings
      # nixcord
      ../../../desktop/nixcord/settings-home.nix
      # obsidian
      ../../../desktop/obsidian/settings-home.nix
      # steam
      ../../../desktop/steam/startup-home.nix
      # Strawberry
      ../../../desktop/strawberry/bind-home.nix # Global Hotkeys for music player
      # VScode
      ../../../desktop/vscode/settings-home.nix
      ../../../desktop/vscode/language/javascript-home.nix # ESlint
      ../../../desktop/vscode/language/nix-home.nix # Nix LSP and FMT support

    ];

    user = "reese";

    hostName = "template";

    static = {
      # only needed when using networking-static-nix.nix
      interface = "enp10s0";
      ipv4 = {
        address = "192.168.1.1";
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

    programs = with pkgs; [
      featherpad
      krita
      gimp3

      git
      vlc
      nano
    ];

    bluetooth = true;

    # home manager vars
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
    primaryMonitor = "HDMI-A-1";
    monitor = [
      "HDMI-A-1, 1920x1080@60, 0x0, 1"
      "DP-3, 2560x1440@165, 1920x-200, 2, transform,3"
      "DP-2, 1920x1080@60, -960x375, 2"
    ];
  };
in
template
