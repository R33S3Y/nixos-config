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
          autocorrect = true;
          hideAddToDictionaryCodeActions = true; # hides some ctl + shift + p options that wont work.
          diagnosticLevel = "Warning"; # if it hits a limit
          maxDuplicateProblems = 1000;
          maxNumberOfProblems = 10000;
          suggestionMenuType = "quickFix";
          minWordLength = 1;
          revealIssuesAfterDelayMS = 200;
          checkLimit = 10000;
          cSpell.userWords = [
            # their is a option to use make a custom dictionary that may prove useful if this list gets too long
            "stylix"
            "pkgs"
            "nixos"
          ];
        };
      };
    };
  };
}
