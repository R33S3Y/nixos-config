{ config, specialArgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = specialArgs;

  home-manager.users."${config.system.user}" = import ./system-home.nix;
}
