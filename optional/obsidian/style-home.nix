{ config, pkgs, ... }:
{ 
  stylix.targets.obsidian.vaultNames = [
    "lapisLazuli/reese/NoteBox"
    "Desktop"
  ];
  programs.obsidian = {
    enable = true;
    defaultSettings.app = {
      "useMarkdownLinks": true
    };
    vaultNames = {
      "lapisLazuli/reese/NoteBox".settings.app = {
        "attachmentFolderPath": "Assets"
      }
    }
  }
}
