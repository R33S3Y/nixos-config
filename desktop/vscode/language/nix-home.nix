{ config, pkgs, ... }:

{ 
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [ 
        vscode-extensions.jnoortheen.nix-ide
      ];
      userSettings = { 
        
      };
    };
  };
}
