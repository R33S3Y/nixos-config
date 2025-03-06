{ config, pkgs, ... }:

{
  stylix.targets.vscode.enable = true;
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
    };
  };
}