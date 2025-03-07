
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];
}
