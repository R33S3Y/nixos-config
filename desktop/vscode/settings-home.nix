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
      userSettings = {
        "chat.editor.fontSize" = 14;
        "debug.console.fontSize" = 14;
        "editor.fontSize" = 14;
        "editor.minimap.sectionHeaderFontSize" = 9;
        "markdown.preview.fontSize" = 14;
        "scm.inputFontSize" = 13;
        "screencastMode.fontSize" = 58;
        "terminal.integrated.fontSize" = 14;
      }
    };
  };
}