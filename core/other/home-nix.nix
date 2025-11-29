{ config, pkgs, specialArgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit (specialArgs) var system; # keep your existing vars
    nur = specialArgs.nur;            # pass nur through
  };

  home-manager.users."${specialArgs.var.${specialArgs.system}.username}" = import ./home-home.nix;
}