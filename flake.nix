{
  description = "NixOS Configuration for Diamond";

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

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Detect the hostname, with a fallback if HOSTNAME is unset
      hostName = let
        envHostName = builtins.getEnv "HOSTNAME";
        in if envHostName != "" then envHostName else "Diamond-NixOS";

      # Configurations
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
          specialArgs = { inherit inputs; };
          modules = [
            (builtins.getAttr hostName hostConfigs)  # Avoids premature lookup
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            nur.modules.nixos.default
            nur.legacyPackages."${system}".repos.iopq.modules.xraya
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.reese = {
                imports = [
                  (builtins.getAttr hostName homeConfigs)  # Same fix for homeConfigs
                ];
              };
            }
          ];
        }
      ) hostConfigs;
    };
}
