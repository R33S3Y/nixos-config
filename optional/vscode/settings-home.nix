{ config, pkgs, ... }:

{
  stylix.targets.vscode.enable = true;
  stylix.targets.vscode.profileNames = [ "default" ];
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = [ 
        pkgs.vscode-extensions.bbenoist.nix 
        pkgs.vscode-extensions.naumovs.color-highlight 
        pkgs.vscode-extensions.ms-python.python
      ];
    };
  };
}