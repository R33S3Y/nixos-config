{
  description = "NixOS Configuration for Diamond";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      diamond = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          nixpkgs.config.allowUnfree = true;
        };
        modules = [
          ./hosts/diamond/imports-nix.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager     
        ];
      };
      obsidian = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/obsidian/imports-nix.nix
        ];
      };
    };

    deploy = {
      nodes = {
        diamond = {
          hostname = "localhost"; # Always local
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.diamond;
          };
        };

        obsidian = {
          hostname = "192.168.1.249"; # Or obsidian.lan
          profiles.system = {
            user = "reese"; # SSH user
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.obsidian;
          };
        };
      };
    };
  };
}
