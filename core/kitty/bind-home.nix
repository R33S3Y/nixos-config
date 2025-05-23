{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+c" = ''send_text all \x03'';
      "escape" = "send_text \x03\\";
    };
  };
}