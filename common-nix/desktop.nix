
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

  environment.systemPackages = with pkgs; [
    kitty # cmd
    spacedrive #file manager
    rofi-wayland # start menu
    hyprpaper
    hyprlock
    waybar
  ];
}
