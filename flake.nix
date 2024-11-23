{
  description = "NixOS Configuration for Diamond and Amethyst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Detect the hostname using builtins
      hostName = builtins.getEnv "HOSTNAME";

      # Configurations
      commonConfig = ./hosts/common.nix;
      homeCommonConfig = ./home/home-common.nix;

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
      nixosConfigurations = {
        ${hostName} = pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            commonConfig
            hostConfigs.${hostName}
            homeCommonConfig
            homeConfigs.${hostName}
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
