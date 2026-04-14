{ config, pkgs, ... }:

{
  stylix.targets.vscode = {
    enable = true;
    fonts.enable = true;
    colors.enable = true;
    profileNames = [ "default" ];
  };
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = [ 
        #pkgs.vscode-extensions.bbenoist.nix 
        #pkgs.vscode-extensions.naumovs.color-highlight 
        #pkgs.vscode-extensions.ms-python.python
      ];
      userSettings = { 
        
      };
    };
  };
}
