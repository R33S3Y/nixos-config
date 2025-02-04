
{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {
    text = ''
      auth      include     login
      account   include     login
      password  include     login
      session   include     login
    '';
  };
  services.udisks2.enable = true; #need to see other disks in file managers

  environment.systemPackages = with pkgs; [
    kitty # cmd
    spacedrive #file manager
    kdePackages.dolphin
    rofi-wayland # start menu
    hyprpaper
    hyprlock
    hyprpicker
    hyprshot
    waybar
  ];
}
