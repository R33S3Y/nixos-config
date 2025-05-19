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

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations = {
      diamond = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/diamond/imports-nix.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nur.modules.nixos.default
          nur.legacyPackages.x86_64-linux.repos.iopq.modules.xraya
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.reese = {
              imports = [
                ./hosts/diamond/imports-home.nix
              ];
            };
          }
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
    deploy.nodes = {
      diamond = {
        hostname = "diamond";
        sshUser = "reese";     
        profiles.system = {
          user = "reese";
          path = self.nixosConfigurations.diamond.config.system.build.toplevel;
        };
      };

      obsidian = {
        hostname = "192.168.1.249"; # obsidian
        sshUser = "reese";
        profiles.system = {
          user = "reese";
          path = self.nixosConfigurations.obsidian.config.system.build.toplevel;
        };
      };
    };

    deploy.defaults = {
      magicRollback = true;
      autoRollback = true;
    };
  };
}
