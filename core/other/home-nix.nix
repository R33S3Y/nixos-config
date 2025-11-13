{ config, pkgs, specialArgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  h ome-manager.users."${specialArgs.var.${specialArgs.system}.username}" = import ./home-home.nix {  inherit specialArgs;  };
}