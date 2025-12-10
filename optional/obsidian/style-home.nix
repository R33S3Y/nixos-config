{ config, pkgs, ... }:
{ 
  stylix.targets.obsidian.vaultNames = [
    "NoteBox"
    "Desktop"
  ];
  programs.obsidian.enable = true;
}
