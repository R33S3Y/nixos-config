
{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    kitty # required for the default Hyprland config
    libsForQt5.dolphin
    wofi
    hyprpaper
    hyprlock
    waybar
  ];
}
