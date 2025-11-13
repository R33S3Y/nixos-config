{ config, pkgs, specialArgs, ... }:
{

  config.home-manager.useGlobalPkgs = true;
  config.home-manager.useUserPackages = true;

  config.home-manager.users.reese = import ./home-home.nix {  inherit specialArgs;  };
}