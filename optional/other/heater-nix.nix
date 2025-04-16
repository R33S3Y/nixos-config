
{ config, pkgs, ... }:

{
  services.foldingathome.enable = true;

  environment.systemPackages = with pkgs; [ fahcontrol ];
}