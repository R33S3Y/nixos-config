{ config, pkgs, specialArgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = specialArgs;

  home-manager.users."${specialArgs.hosts.${specialArgs.host}.username}" = import ./home-home.nix;
}