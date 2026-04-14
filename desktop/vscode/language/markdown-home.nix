{ ... }:

{ 
  programs.vscode = {
    profiles.default = {
      userSettings = {
        markdown.typographer = true;
        workbench.editorAssociations = {
          "*.md" = "vscode.markdown.preview.editor";
        };
      };
    };
  };
}
