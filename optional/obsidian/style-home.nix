{ config, pkgs, ... }:
{ 
  stylix.targets.obsidian.vaultNames = [
    "lapis_lazuli/users/reese/NoteBox"
    "Desktop"
  ];
  programs.obsidian.enable = true;
}
