
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fah-client
  ];

  
}