
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.breeze-icons
    pkgs.kdePackages.breeze
  ];
  nixpkgs.config.qt = {
    enable = true;
    platformTheme = "qt5ct"; 
    style = {
      package = pkgs.kdePackages.breeze;
      name = "Breeze-Dark";
    };
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
  environment.variables.QT_QPA_PLATFORM = "wayland";

  stylix.targets.qt.enable = false;
}