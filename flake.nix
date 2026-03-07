{
  description = "NixOS Configuration for all my PC's";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix.url = "github:danth/stylix";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-minecraft, nixpkgs-unstable, ... }@inputs: 
  let 
    system = "x86_64-linux";

    unstablePkgs = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    mkHost = hostName:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hosts users themes;

          host = hostName;
          user = hosts.${hostName}.user;
          theme = users.${hosts.${hostName}.user}.theme;
        };

        modules = hosts.${hostName}.imports ++ [
          ({ config, pkgs, ... }: {
          
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            (final: prev: {
              unstable = unstablePkgs;
            })
          ];

        })
        ];
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
    themes = {
      diamond = import ./data/themes/diamond/theme-flake.nix {
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
