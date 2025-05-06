
{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession = true;
  };
  programs.gamescope.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libsForQt5.kate
    krita

    git
    vlc
    nano
    discord
    
    prismlauncher
    python314
    obsidian

    protonup-qt #needed for a vrchat fix

    bs-manager 

    r2modman
    orca-slicer
    openscad

    gamescope
    qtcreator
  ];
} 