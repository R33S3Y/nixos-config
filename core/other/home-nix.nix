{ config, pkgs, specialArgs, ... }:
let
  username = specialArgs.var.${specialArgs.system}.username;
in
{

  config.home-manager.useGlobalPkgs = true;
  config.home-manager.useUserPackages = true;

  config.home-manager.users.${username} = import ./home-home.nix {  inherit specialArgs;  };
}