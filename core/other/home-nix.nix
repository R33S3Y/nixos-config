{ config, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = config.system;

  home-manager.users."${config.system.users.${config.system.user}.name}" = import ./system-home.nix;
}
