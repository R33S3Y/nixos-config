{ config, pkgs, ... }:

{
  stylix.targets.vscode.enable = true;
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
  };
}