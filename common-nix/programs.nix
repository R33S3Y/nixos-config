
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fastfetch # for: /common-home/bash.nix
    unzip
  ];
}
