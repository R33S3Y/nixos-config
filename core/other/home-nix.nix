{ config, pkgs, specialArgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = specialArgs;

  home-manager.users."${specialArgs.users.${specialArgs.user}.name}" = import ./home-home.nix;
}