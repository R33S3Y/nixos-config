{ config, pkgs, ... }:
{ 
  stylix.targets.obsidian.vaultNames = [
    #"lapisLazuli/reese/NoteBox"
    "Desktop"
  ];
  programs.obsidian.enable = true;
}
