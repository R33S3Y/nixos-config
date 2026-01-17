
{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  
  programs.nixcord.enable = true;

  stylix.targets.nixcord = { 
    colors = {
      enable = true;
    };
  };
}