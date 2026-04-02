
{ config, pkgs, inputs, ... }:

{
  stylix.targets.vencord = { 
    colors = {
      enable = true;
    };
  };
}