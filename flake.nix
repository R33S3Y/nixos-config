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
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-minecraft, ... }@inputs: 
  let 
    hosts = {
      bort = import ./data/hosts/bort/var-flake.nix {
        inherit inputs home-manager nur nix-minecraft;
      };
      cinnabar = import ./data/hosts/cinnabar/var-flake.nix {
        inherit inputs home-manager nur;
      };
      diamond = import ./data/hosts/diamond/var-flake.nix {
        inherit inputs home-manager nur;
      };
      morganite = import ./data/hosts/morganite/var-flake.nix {
        inherit inputs home-manager;
      };
      obsidian = import ./data/hosts/obsidian/var-flake.nix {
        inherit inputs home-manager;
      };
      template = import ./data/hosts/template/var-flake.nix {
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
          host = "bort";
          hosts = hosts;
        };
        modules = hosts.bort.imports;
      };
      cinnabar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          nixpkgs.config.allowUnfree = true;
          host = "cinnabar";
          hosts = hosts;
        };
        modules = hosts.cinnabar.imports;
      };
      diamond = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          nixpkgs.config.allowUnfree = true;
          host = "diamond";
          hosts = hosts;
        };
        modules = hosts.diamond.imports;
      };
      obsidian = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          host = "obsidian";
          hosts = hosts;
        };
        modules = hosts.obsidian.imports;
      };
      morganite = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          host = "morganite";
          hosts = hosts;
        };
        modules = hosts.morganite.imports;
      };
    };
  };
}
