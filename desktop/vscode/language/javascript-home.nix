{ pkgs, ... }:

{ 
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [ 
        vscode-extensions.dbaeumer.vscode-eslint
      ];
      userSettings = {
        
      };
    };
  };
}
