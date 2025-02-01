
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
  environment.sessionVariables = rec {
    XDG_DATA_DIRS=/nix/store/a6qb8whj2ad7lizr0ghag2a63nss39f7-hicolor-icon-theme-0.18/share:/nix/store/zisyg7919dsx2r28zhggdab4r6xmb257-rofi-1.7.5+wayland3/share:/nix/store/l8x0x87qb2y5j71ff42nbnsqd6jpgdz8-gsettings-desktop-schemas-47.1/share/gsettings-schemas/gsettings-desktop-schemas-47.1:/nix/store/0whdwl2a2jcykffs7p60h32khzlp2ksd-gtk+3-3.24.43/share/gsettings-schemas/gtk+3-3.24.43:/nix/store/hxlyzfdn7fawvd8ahg9w63g5sfw69qhv-desktops/share:/home/reese/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/home/reese/.nix-profile/share:/nix/profile/share:/home/reese/.local/state/nix/profile/share:/etc/profiles/per-user/reese/share:/nix/var/nix/profiles/default/share:/run/current-system/sw/share
  };
}
