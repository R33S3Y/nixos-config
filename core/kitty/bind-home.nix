{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+shift+c" = "send_text all \x03";
    };
  };
}