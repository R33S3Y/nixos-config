
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi-wayland # start menu
  ];
}
