{ pkgs, ... }:

{
  stylix.targets.vscode = {
    enable = true;
    fonts.enable = true;
    colors.enable = true;
    profileNames = [ "default" ];
  };
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = with pkgs; [
        vscode-extensions.streetsidesoftware.code-spell-checker
      ];
      userSettings = {
        editor = {
          tabSize = 2; # sets tabSize
          insertSpaces = true; # Space when tab
          detectIndentation = false; # turns off auto detect for tabSize
        };
        files = {
          trimTrailingWhitespace = true;
          insertFinalNewline = true;
          trimFinalNewlines = true;
        };
        editor = {
          formatOnSave = true;
          formatOnPaste = true;
        };
        cSpell = {
          language = "en-GB,en-NZ";
          userWords = [

          ];
        };
      };
    };
  };
}
