{ config, pkgs, specialArgs, ... }:
{
  imports = specialArgs.var.imports;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users."${specialArgs.var.username}" = import ./imports-home.nix;
}
