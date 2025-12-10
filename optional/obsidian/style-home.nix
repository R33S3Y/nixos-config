{ config, pkgs, ... }:
{ 
  stylix.targets.obsidian.vaultNames = [
    "/mnt/lapisLazuli/reese/NoteBox"
    "Desktop"
  ];
  programs.obsidian.enable = true;
}
