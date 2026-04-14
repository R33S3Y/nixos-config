{ config, pkgs, ... }:

{ 
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  programs.vscode = {
    profiles.default = {
      extensions = [ 
        vscode-extensions.jnoortheen.nix-ide
      ];
      userSettings = { 
        
      };
    };
  };
}
