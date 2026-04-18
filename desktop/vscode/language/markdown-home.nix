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
        workbench.editorAssociations = {
          "*.md" = "vscode.markdown.preview.editor";
        };
      };
    };
  };
}
