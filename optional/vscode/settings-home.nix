{ config, pkgs, userName, ... }:

{
  stylix.targets.vscode.enable = true;
  stylix.targets.vscode.profileNames = [ "${username}" ];
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
    };
  };
}