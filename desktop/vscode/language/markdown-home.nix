{ pkgs, ... }:

{ 
  home.packages = with pkgs; [ 
    markdown-oxide 
  ];

  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [ 
        markdown-oxide
      ];
      userSettings = {
        markdown.typographer = true;
        workbench.editorAssociations = {
          "*.md" = "vscode.markdown.preview.editor";
        };
      };
    };
  };
}
