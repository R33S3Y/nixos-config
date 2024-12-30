{ config, pkgs, ... }:
{
  stylix.targets.kitty.enable = false;
  
  programs.kitty.enable = true;

  home.file."/.config/kitty/current-theme.conf".text = ''
    color0 #${config.stylix.base16Scheme.base00} #: Black
    color1 #${config.stylix.base16Scheme.base01} #: RED
    color2 #${config.stylix.base16Scheme.base02} #: GREEN
    color3 #${config.stylix.base16Scheme.base03} #: HIGHLIGH
    color4 #${config.stylix.base16Scheme.base04} #: BLUE
    color5 #${config.stylix.base16Scheme.base05} #: MAGENTA
    color6 #${config.stylix.base16Scheme.base06} #: CYAN
    color7 #${config.stylix.base16Scheme.base07} #: WHITE
    color8 #${config.stylix.base16Scheme.base08} #: BR BLACK
    color9 #${config.stylix.base16Scheme.base09} #: BR RED
    color10 #${config.stylix.base16Scheme.base0A} #: BR GREEN
    color11 #${config.stylix.base16Scheme.base0B} #: BR YELLOW
    color12 #${config.stylix.base16Scheme.base0C} #: BR BLUE
    color13 #${config.stylix.base16Scheme.base0D} #: BR MAGENTA
    color14 #${config.stylix.base16Scheme.base0E} #: BR CYAN
    color15 #${config.stylix.base16Scheme.base0F} #: BR WHITE
  '';

#: The basic colors

#foreground #8b8792
#background #19171c
#selection_foreground #8b8792
#selection_background #26232a


#: Cursor colors

#cursor #8b8792
#cursor_text_color #19171c


#: URL underline color when hovering with mouse

#url_color #a06e3b


#: kitty window border colors and terminal bell colors

#active_border_color #655f6d
#inactive_border_color #19171c
#bell_border_color #aa573c
#visual_bell_color none


#: OS Window titlebar colors

#wayland_titlebar_color #26232a
#macos_titlebar_color #26232a


#: Tab bar colors

#active_tab_foreground #e2dfe73
#active_tab_background #19171c
#inactive_tab_foreground #8b8792
#inactive_tab_background #26232a
#tab_bar_background #26232a
#tab_bar_margin_color none


#: Colors for marks (marked text in the terminal)

#mark1_foreground #19171c
#mark1_background #e2dfe7
#mark2_foreground #19171c
#mark2_background #a06e3b
#mark3_foreground #19171c
#mark3_background #2a9292




  #    enable_audio_bell = false;
  #    url_style = ''single'';
  #    cursor_shape = ''block'';
  #    confirm_os_window_close = 0;
  #    font_size = 11;
      
      
    
  
}