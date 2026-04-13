
{ config, pkgs, ... }:

{ 
  stylix.targets.helix = {
    colors.enable = true;
  };
  programs.helix = {
    enable = true;
  }
}