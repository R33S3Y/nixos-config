{ config, pkgs, specialArgs, ... }:
{

  config.home-manager.useGlobalPkgs = true;
  config.home-manager.useUserPackages = true;

  #config.home-manager.users."${specialArgs.var.${specialArgs.system}.username}" = import ./home-home.nix {  inherit specialArgs;  };
}