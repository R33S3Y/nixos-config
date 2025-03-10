
{ config, pkgs, ... }:

{
  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libsForQt5.kate
    krita

    git
    vlc
    nano
    dnslookup
    discord
    
    prismlauncher
    python314
    btop
    obsidian

    protonup-qt #needed for a vrchat fix

    bs-manager 
  ];
}