{ config, pkgs, specialArgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = specialArgs;

  home-manager.users."${specialArgs.var.${specialArgs.system}.username}" = import ./home-home.nix;
}