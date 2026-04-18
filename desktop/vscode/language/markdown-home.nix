{ pkgs, ... }:

{ 
  programs.vscode = {
    profiles.default = {
      userSettings = {
        workbench.editorAssociations = {
          "*.md" = "vscode.markdown.preview.editor";
        };
      };
    };
  };
}
