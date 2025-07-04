{
  description = "NixOS Configuration for Diamond";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
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
          {
            nixpkgs.overlays = [
              inputs.hyprpanel.overlay
            ];
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
  };
}
