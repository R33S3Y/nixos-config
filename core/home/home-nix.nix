{ system, ... }:
{

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {
      system = system;
    };

    users."${system.user}" = import ./home-home.nix;
  };
}
