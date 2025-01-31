
{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    kitty # cmd
    spacedrive #file manager
    rofi-wayland # start menu
    hyprpaper
    hyprlock
    waybar
  ];
}
