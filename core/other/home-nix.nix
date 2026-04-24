{
  config,
  pkgs,
  system,
  ...
}:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = system;

  home-manager.users."${system.users.${system.user}.name}" = import ./home-home.nix;
}
