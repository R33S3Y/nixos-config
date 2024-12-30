
{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    kitty # required for the default Hyprland config
    kdePackages.dolphin
    wofi
    hyprpaper
    hyprlock
    waybar
  ];
}
