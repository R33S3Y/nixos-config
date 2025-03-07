{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      url_style = ''single'';
      cursor_shape = ''block'';
      confirm_os_window_close = 0;
    };
  };
}