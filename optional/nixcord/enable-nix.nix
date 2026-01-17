
{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    vencord
  ];
  
  stylix.targets.vencord = { 
    colors = {
      enable = true;
    };
  };
}