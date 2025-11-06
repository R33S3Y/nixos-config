
{ config, pkgs, inputs, lib, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope.enable = true;
} 