
{ config, pkgs, inputs, lib, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    featherpad
    krita
    gimp3

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
    blender-hip

    obs-studio

    keymapp 

    kicad
    libreoffice-qt6-fresh

    qtcreator
    cmake
    gdb

    qbittorrent

    nfs-utils
  ];

  stylix.targets.qt.enable = false;

} 