{ config, pkgs, specialArgs, ... }:
{
  imports = config.var.${specialArgs.system}.imports;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users."${config.var.${specialArgs.system}.username}" = import ./imports-home.nix;
}
