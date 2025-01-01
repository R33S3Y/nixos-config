
{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.steam.enable = true;

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
    kdePackages.qt6ct
    prismlauncher
  ];
}