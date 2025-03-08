let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };

  hostName = let
    envHostName = builtins.getEnv "HOSTNAME";
  in if envHostName != "" then envHostName else "Diamond-NixOS";

  userName = "reese";  # Define your username here

  hostConfigs = {
    "Diamond-NixOS" = ./hosts/diamond/imports-nix.nix;
  };

  homeConfigs = {
    "Diamond-NixOS" = ./hosts/diamond/imports-home.nix;
  };
in
{
  nixosConfigurations = builtins.mapAttrs (host: hostConfigPath:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs userName; };  # Pass userName
      modules = [
        (builtins.getAttr hostName hostConfigs)
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        nur.modules.nixos.default
        nur.legacyPackages."${system}".repos.iopq.modules.xraya
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${userName}" = {
            imports = [
              (builtins.getAttr hostName homeConfigs)
            ];
          };
        }
      ];
    }
  ) hostConfigs;
}
