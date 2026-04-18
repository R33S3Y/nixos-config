{ ... }:
{
  stylix.targets.obsidian.vaultNames = [
    "lapisLazuli/reese/NoteBox"
    "Desktop"
  ];
  programs.obsidian = {
    enable = true;
    defaultSettings.app = {
      "useMarkdownLinks" = true;
      "newLinkFormat" = "relative";
    };
    vaults = {
      "lapisLazuli/reese/NoteBox".settings.app = {
        "attachmentFolderPath" = "Assets";
        "useMarkdownLinks" = true;
        "newLinkFormat" = "relative";
      };
    };
  };
}
