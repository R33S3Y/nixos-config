{
  description = "NixOS Configuration for Diamond and Amethyst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Detect the hostname, with a fallback if HOSTNAME is unset
      hostName = if builtins.hasEnv "HOSTNAME" 
                 then builtins.getEnv "HOSTNAME" 
                 else "Diamond-NixOS";

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
          modules = [
            commonConfig
            hostConfigPath
          ];
        }
      ) hostConfigs;

      homeConfigurations = {
        "reese@${hostName}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          #extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            homeCommonConfig
            homeConfigs.${hostName}
          ];
        };
      };
    };
}
