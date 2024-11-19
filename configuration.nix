
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix

      ./nix.nix
      ./local.nix

      ./networking.nix
      ./print.nix
      ./bluetooth.nix
      ./sound.nix

      ./users.nix
      ./programs.nix

      ./plasma.nix
      ./x11.nix
    ];
}
