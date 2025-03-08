{ config, pkgs, ... }:

{
  stylix.targets.vscode.enable = true;
  stylix.targets.vscode.profileNames = [ config.var.username ];
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
    };
  };
}