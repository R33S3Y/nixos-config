
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
  ];
  nixpkgs.config.qt6 = {
    enable = true;
    platformTheme = "qt6ct"; 
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
}
