{
  description = "NixOS Configuration for Diamond and Amethyst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    stylix.url = "github:danth/stylix";
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
      homeCommonConfig = ./home/common.nix;

      hostConfigs = {
        "Diamond-NixOS" = ./hosts/diamond.nix;
        "Amethyst-NixOS" = ./hosts/amethyst.nix;
      };

      homeConfigs = {
        "Diamond-NixOS" = ./home/diamond.nix;
        "Amethyst-NixOS" = ./home/amethyst.nix;
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
              home-manager.users.reese = import homeConfigs.${hostName};


            }
          ];
        }
      ) hostConfigs;

      #homeConfigurations = {
      #  "reese@${hostName}" = home-manager.lib.homeManagerConfiguration {
      #    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
      #    #extraSpecialArgs = {inherit inputs outputs;};
      #    modules = [
      #      homeCommonConfig
      #      homeConfigs.${hostName}
      #    ];
      #  };
      #};
    };
}
