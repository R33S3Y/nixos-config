
{ config, pkgs, unstable, ... }:

{
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.libsForQt5.kate
    pkgs.krita
    pkgs.vscode
    pkgs.git
    pkgs.lutris
    pkgs.vlc
    pkgs.strawberry
    pkgs.nano

    unstable.alvr
    pkgs.prismlauncher
  ];
}