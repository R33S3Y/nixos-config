{ config, pkgs, specialArgs, ... }:
{
  #imports = specialArgs.var.${specialArgs.system}.imports;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users."${specialArgs.var.${specialArgs.system}.username}" = import ./imports-home.nix;
}
