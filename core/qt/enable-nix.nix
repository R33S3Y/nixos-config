
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qt6ct
    kdePackages.breeze-icons
    kdePackages.breeze
  ];
  nixpkgs.config.qt = {
    enable = true;
    platformTheme = "qt6ct"; 
    style = {
      package = pkgs.kdePackages.breeze;
      name = "Breeze-Dark";
    };
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
  environment.variables.QT_QPA_PLATFORM = "wayland";

  stylix.targets.qt.enable = false;
}