{ ... }:

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
      extensions = [ 
        
      ];
      userSettings = { 
        editor = {
          tabSize = 2; # sets tabsize
          detectIndentation = false; # turns off auto detect for tabSize
        };
      };
    };
  };
}
