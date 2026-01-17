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
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-minecraft, ... }@inputs: 
  let 
    var = {
      bort = import ./hosts/bort/var-flake.nix {
        inherit inputs home-manager nur nix-minecraft;
      };
      cinnabar = import ./hosts/cinnabar/var-flake.nix {
        inherit inputs home-manager nur;
      };
      diamond = import ./hosts/diamond/var-flake.nix {
        inherit inputs home-manager nur;
      };
      morganite = import ./hosts/morganite/var-flake.nix {
        inherit inputs home-manager;
      };
      obsidian = import ./hosts/obsidian/var-flake.nix {
        inherit inputs home-manager;
      };
      template = import ./hosts/template/var-flake.nix {
        inherit inputs home-manager nur nix-minecraft;
      };
    };
  in
  {
    nixosConfigurations = {
      bort = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          nixpkgs.config.allowUnfree = true;
          system = "bort";
          var = var;
        };
        modules = var.bort.imports;
      };
      cinnabar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          nixpkgs.config.allowUnfree = true;
          system = "cinnabar";
          var = var;
        };
        modules = var.cinnabar.imports;
      };
      diamond = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          nixpkgs.config.allowUnfree = true;
          system = "diamond";
          var = var;
        };
        modules = var.diamond.imports;
      };
      obsidian = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          system = "obsidian";
          var = var;
        };
        modules = var.obsidian.imports;
      };
      morganite = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          system = "morganite";
          var = var;
        };
        modules = var.morganite.imports;
      };
    };
  };
}
