{ config, pkgs, specialArgs, nur, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit (specialArgs) var system; # keep your existing vars
    nur = nur;            # pass nur through
  };

  home-manager.users."${specialArgs.var.${specialArgs.system}.username}" = import ./home-home.nix;
}