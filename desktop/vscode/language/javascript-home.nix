{ pkgs, ... }:

{
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [
        vscode-extensions.dbaeumer.vscode-eslint
        vscode-extensions.prettier.prettier-vscode
      ];
      userSettings = {

      };
    };
  };
}
