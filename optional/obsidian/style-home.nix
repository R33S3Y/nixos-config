{ config, pkgs, ... }:
{ 
  stylix.targets.obsidian.vaultNames = [
    "lapisLazuli/reese/NoteBox"
    "Desktop"
  ];
  home.file = {
    lapisLazuli.source = config.lib.file.mkOutOfStoreSymlink "/mnt/lapisLazuli";
  };
  programs.obsidian.enable = true;
}
