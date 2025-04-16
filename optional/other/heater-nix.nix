
{ config, pkgs, ... }:

{
  services.foldingathome.enable = true;

  environment.systemPackages = with pkgs; [ fah-control ];
}