
{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.steam.enable = true;

  services.flatpak.enable = true; # needed for bs manager

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libsForQt5.kate
    krita
    vscode
    git
    vlc
    strawberry
    nano
    
    prismlauncher
    python314
    btop
    obsidian

    protonup-qt #needed for a vrchat fix
  ];
}