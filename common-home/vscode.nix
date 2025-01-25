{ config, pkgs, ... }:

{
  stylix.targets.vscode.enable = false;
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    extensions = [ pkgs.vscode-extension-bbenoist-Nix ];
  };
}