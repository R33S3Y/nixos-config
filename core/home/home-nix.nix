{ system, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = { system = system; };

  home-manager.users."${system.user}" = import ./home-home.nix;
}
