{
  inputs,
  home-manager,
  nur,
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
      # CORE
      # boot
      ../../../core/boot/uefi-nix.nix
      ../../../core/boot/style-nix.nix

      # Hyprland
      ../../../desktop/hyprland/enable-nix.nix

      # Hyprlock
      ../../../desktop/hyprlock/enable-nix.nix

      # Hyprpanel
      ../../../desktop/hyprpanel/enable-nix.nix

      # Kitty
      ../../../desktop/kitty/enable-nix.nix

      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../../core/lazyUpdate/enable-nix.nix

      # PCmanFM
      ../../../desktop/pcmanfm/enable-nix.nix

      # Rofi
      ../../../core/rofi/enable-nix.nix

      # SDDM
      ../../../desktop/sddm/enable-nix.nix

      # Other
      ../../../core/other/home-nix.nix # home
      ../../../core/other/journald-nix.nix # journald  -  adds a fix that explicity limits how much storage logs are allow to take at 2GB
      ../../../core/other/local-nix.nix # Local settings
      ../../../core/other/networking-nix.nix
      ../../../core/other/nix-nix.nix # Nix settings  -  enable flakes, state nix version, etc
      ../../../core/other/cmd-nix.nix # CMD  -  Programs that are still needed. But dont need there own section
      ../../../core/other/user-nix.nix # user  -  Adds a user
      ../../../core/other/ssh-nix.nix # ssh  -  Enables ssh on port 22 needed for deploy rs
      ../../../core/style/stylix-nix.nix # stylix  -  this repo expects stylix
      ../../../core/other/sudo-nix.nix # sudo  -  Sudo settings
      ../../../desktop/other/x11-nix.nix # x11  -  needed for Xwayland??

      # OPTIONAL
      # You can comment and uncomment these as needed

      # btop
      ../../../core/btop/enable-nix.nix

      # Fast Fetch
      ../../../core/fastfetch/enable-nix.nix # Fastfetch  -  You got to show something in that cmd for your reddit posts

      # Firefox
      ../../../desktop/firefox/enable-nix.nix

      # LapisLazuli
      ../../../other/lapisLazuli/nfs-nix.nix # Lapius  -  NAS

      # other
      ../../../core/other/programs-nix.nix

      # My stuff
      ./hardware-configuration.nix # hardware  -  your hardware settings

    ];
    homeImports = [
      # CORE
      # Hyprland
      ../../../desktop/hyprland/bind-home.nix # Keyboard bindings
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

      # lazyUpdate - update on rebulid script - requres passwordless nixos-rebuild provided by sudo-nix.nix
      ../../../core/lazyUpdate/run-home.nix

      # PCmanFM
      # No home-manager files

      # Rofi
      ../../../core/rofi/style-home.nix # Styles

      # SDDM
      # TODO : SDDM styles

      # Other
      ../../../core/other/xdgMime-home.nix # Sets default apps

      # OPTIONAL
      # You can comment and uncomment these as needed

      # btop
      ../../../core/btop/style-home.nix

      # Fast Fetch
      ../../../core/fastfetch/settings-home.nix # Fastfetch  -  run on bash init

      # Firefox
      ../../../desktop/firefox/settings-home.nix

      # Other
      # No home-manager files
    ];

    user = "reese";

    hostName = "cinnabar";

    programs = with pkgs; [
      handbrake
      libdvdcss
      ffmpeg-full
    ];

    # home manager vars
    primaryMonitor = "Unknown-1";

    monitor = [
      "Unknown-1, 1920x1080@60, 0x0, 2"
    ];

  };
in
template
