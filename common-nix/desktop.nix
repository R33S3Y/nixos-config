
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

  #needed to see other disks in file managers
  services.udisks2.enable = true; 
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    kitty # cmd
    pcmanfm
    rofi-wayland # start menu
    hyprpaper
    hyprlock
    hyprpicker
    hyprshot
    waybar
  ];
}
