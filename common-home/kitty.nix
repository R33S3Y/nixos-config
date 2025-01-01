{ config, pkgs, ... }:

{
  stylix.targets.kitty.enable = false;
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      url_style = ''single'';
      cursor_shape = ''block'';
      confirm_os_window_close = 0;
      font_size = 11;
      background = ''#${config.stylix.base16Scheme.base00}'';
      foreground = ''#F8F8F2'';
      selection_foreground = ''#1E1F28'';
      selection_background = ''#44475A'';
      color0 = ''#${config.stylix.base16Scheme.base00}''; # Black
      color1 = ''#${config.stylix.base16Scheme.base08}''; # RED
      color2 = ''#${config.stylix.base16Scheme.base09}''; # GREEN
      color3 = ''#${config.stylix.base16Scheme.base0A}''; # HIGHLIGH
      color4 = ''#${config.stylix.base16Scheme.base04}''; # BLUE
      color5 = ''#${config.stylix.base16Scheme.base05}''; # MAGENTA
      color6 = ''#${config.stylix.base16Scheme.base06}''; # CYAN
      color7 = ''#${config.stylix.base16Scheme.base07}''; # WHITE
      color8 = ''#${config.stylix.base16Scheme.base0B}''; # BR BLACK
      color9 = ''#${config.stylix.base16Scheme.base0C}''; # BR RED
      color10 = ''#${config.stylix.base16Scheme.base0D}''; # BR GREEN
      color11 = ''#${config.stylix.base16Scheme.base0E}''; # BR YELLOW
      color12 = ''#${config.stylix.base16Scheme.base0F}''; # BR BLUE
      color13 = ''#${config.stylix.base16Scheme.base01}''; # BR MAGENTA
      color14 = ''#${config.stylix.base16Scheme.base02}''; # BR CYAN
      color15 = ''#${config.stylix.base16Scheme.base03}''; # BR WHITE
      url_color = ''#0087BD''; #URL
      cursor = ''#F4DBD6'';
      cursor_text_color = ''#24273A'';
      active_border_color = ''#B7BDF8'';
      inactive_border_color = ''#6E738D'';
      bell_border_color = ''#EED49F'';
      active_tab_foreground = "#181926";
      active_tab_background = "#C6A0F6";
      inactive_tab_foreground = "#CAD3F5";
      inactive_tab_background = "#1E2030";
      tab_bar_background = "#181926";
    };
  };
}