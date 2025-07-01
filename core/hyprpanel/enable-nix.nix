
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpanel
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
