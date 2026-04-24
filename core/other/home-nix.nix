{ config, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = system;

  home-manager.users."${config.system.users.${config.system.user}.name}" = import ./home-home.nix;
}
