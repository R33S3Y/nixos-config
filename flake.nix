{
  description = "NixOS Configuration for all my PC's";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:NixOS/nixpkgs/nixos-25.11";
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

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      nix-minecraft,
      nixpkgsStable,
      ...
    }@inputs:
    let
      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              inputs
              hosts
              users
              themes
              ;
            nixpkgs.config.allowUnfree = true;

            host = hostName;
            user = hosts.${hostName}.user;
            theme = users.${hosts.${hostName}.user}.theme;
          };

          modules = hosts.${hostName}.imports ++ [
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    stable = import nixpkgsStable {
                      system = "x86_64-linux";
                      config.allowUnfree = true;
                    };
                  })
                ];

              }
            )
          ];
        };

      hosts = {
        bort = import ./data/hosts/bort/host-flake.nix {
          inherit
            inputs
            home-manager
            nur
            nix-minecraft
            ;
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
        #template = import ./data/hosts/template/host-flake.nix {
        #  inherit inputs home-manager nur nix-minecraft;
        #};
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
        bort = mkHost "bort";
        cinnabar = mkHost "cinnabar";
        diamond = mkHost "diamond";
        obsidian = mkHost "obsidian";
        morganite = mkHost "morganite";
        #template = mkHost "template";
      };
    };
}
