
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpicker
    hyprshot
    git
    kdePackages.breeze-icons
  ];
}
