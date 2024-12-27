{ config, pkgs, ... }:
{
  networking.hostName = "Diamond-NixOS";

  imports = [
    ./diamond/hardware-configuration.nix
    ./diamond/programs.nix

    ./diamond/stylix.nix
  ];
}
