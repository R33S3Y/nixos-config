{ pkgs, specialArgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  programs.vscode = {
    profiles.default = {
      extensions = with pkgs; [
        vscode-extensions.jnoortheen.nix-ide
      ];
      userSettings = {
        nix = {
          enableLanguageServer = true;
          serverPath = "nixd";

          serverSettings.nixd = {
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${specialArgs.host}.options";
              home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${specialArgs.host}.options.home-manager.users.type.getSubOptions []";
            };
          };
        };
        "[nix]" = {
          editor.defaultFormatter = "jnoortheen.nix-ide";
          cSpell.ignoreWords = [
            # this is just to shut it up a bit
            "stylix"
            "pkgs"
            "nixos"
          ];
        };
      };
    };
  };
}
