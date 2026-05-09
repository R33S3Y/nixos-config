{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    llvmPackages_20.clang-tools # C / CPP 20
  ];
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [
        vscode-extensions.llvm-vs-code-extensions.vscode-clangd
      ];
      userSettings = {
        "[cpp]" = {
          editor.defaultFormatter = "llvm-vs-code-extensions.vscode-clangd";
        };
        "[c]" = {
          editor.defaultFormatter = "llvm-vs-code-extensions.vscode-clangd";
        };
      };
    };
  };
}
