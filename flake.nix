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
    mkHost = hostName:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs hosts users;
          nixpkgs.config.allowUnfree = true;

          host = hostName;
          user = hosts.${hostName}.user;
        };

        modules = hosts.${hostName}.imports;
      };  

    hosts = {
      bort = import ./data/hosts/bort/host-flake.nix {
        inherit inputs home-manager nur nix-minecraft;
      };
      cinnabar = import ./data/hosts/cinnabar/host-flake.nix {
        inherit inputs home-manager nur;
      };
      diamond = import ./data/hosts/diamond/host-flake.nix {
        inherit inputs home-manager nur;
      };
      morganite = import ./data/hosts/morganite/host-flake.nix {
        inherit inputs home-manager;
      };
      obsidian = import ./data/hosts/obsidian/host-flake.nix {
        inherit inputs home-manager;
      };
      template = import ./data/hosts/template/host-flake.nix {
        inherit inputs home-manager nur nix-minecraft;
      };
    };
    users = {
      reese = import ./data/users/reese/user-flake.nix {
        inherit inputs;
      };
    };
    in
  {
    nixosConfigurations = {
      bort      = mkHost "bort";
      cinnabar  = mkHost "cinnabar";
      diamond   = mkHost "diamond";
      obsidian  = mkHost "obsidian";
      morganite = mkHost "morganite";
    };
  };
}
