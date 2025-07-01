{ config, pkgs, ... }:

{
  stylix.targets.kitty.enable = false;
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 11;
      background = ''#${config.stylix.base16Scheme.base00}'';
      foreground = ''#${config.stylix.base16Scheme.base07}'';
      selection_foreground = ''#${config.stylix.base16Scheme.base00}'';
      selection_background = ''#${config.stylix.base16Scheme.base02}'';
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
      url_color = ''#${config.stylix.base16Scheme.base08}''; #URL
      cursor = ''#${config.stylix.base16Scheme.base07}'';
      cursor_text_color = ''#${config.stylix.base16Scheme.base03}'';
      active_border_color = ''#${config.stylix.base16Scheme.base06}'';
      inactive_border_color = ''#${config.stylix.base16Scheme.base04}'';
      bell_border_color = ''#${config.stylix.base16Scheme.base0B}'';
      active_tab_foreground = ''#${config.stylix.base16Scheme.base00}'';
      active_tab_background = ''#${config.stylix.base16Scheme.base04}'';
      inactive_tab_foreground = ''#${config.stylix.base16Scheme.base07}'';
      inactive_tab_background = ''#${config.stylix.base16Scheme.base01}'';
      tab_bar_background = ''#${config.stylix.base16Scheme.base00}'';
    };
  };
}