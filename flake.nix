{
  description = "NixOS Configuration for Diamond and Amethyst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Detect the hostname, with a fallback if HOSTNAME is unset
      hostName = let
        envHostName = builtins.getEnv "HOSTNAME";
        in if envHostName != "" then envHostName else "Diamond-NixOS";

      # Configurations
      commonConfig = ./hosts/common.nix;
      homeCommonConfig = ./hosts/common-home.nix;

      hostConfigs = {
        "Diamond-NixOS" = ./hosts/diamond.nix;
        "Amethyst-NixOS" = ./hosts/amethyst.nix;
      };

      homeConfigs = {
        "Diamond-NixOS" = ./hosts/diamond-home.nix;
        "Amethyst-NixOS" = ./hosts/amethyst-home.nix;
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs (host: hostConfigPath: 
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            commonConfig
            hostConfigPath
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.reese = {
                imports = [
                  homeCommonConfig
                  homeConfigs.${hostName}
                ];
              };
            }
          ];
        }
      ) hostConfigs;
    };
}
