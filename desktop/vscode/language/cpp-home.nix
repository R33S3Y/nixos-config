{
  pkgs,
  system,
  ...
}:

{
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [
        vscode-extensions.llvm-vs-code-extensions.vscode-clangd
      ];
      userSettings = {
        "[cpp]" = {
          editor.defaultFormatter = "llvm-vs-code-extensions.vscode-clangd";
        };
      };
    };
  };
}
