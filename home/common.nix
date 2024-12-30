{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
  ];
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  home.username = "reese";
  home.homeDirectory = "/home/reese";

  home.file.replace = true; # risky
  
}

