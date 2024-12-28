{ config, pkgs, ... }:
{
  networking.hostName = "Amethyst-NixOS";

  imports = [
    ./amethyst/hardware-configuration.nix
    ./amethyst/programs.nix

    ./amethyst/stylix.nix
  ];
}
