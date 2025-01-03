{ config, pkgs, lib, ... }:
let
  # Define the content of the file
  qtColorConf = builtins.writeText "qt-color.conf" ''
    [ColorScheme]
    active_colors=#${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff
    disabled_colors=#${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff
    inactive_colors=#${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff, #${config.stylix.base16Scheme.base00}ff
  '';
in {
  home.activation.createQtColorConf = lib.mkAfter ''
    mkdir -p ${config.home.homeDirectory}/.config/qt6ct/colors
    cp ${qtColorConf} ${config.home.homeDirectory}/.config/qt6ct/colors/qt-color.conf
  '';

  home.file.".config/qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=/home/reese/.config/qt6ct/colors/qt-colors.conf
    custom_palette=true
    icon_theme=breeze-dark
    standard_dialogs=default
    style=Breeze

    [Fonts]
    fixed="DejaVu Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
    general="DejaVu Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [PaletteEditor]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\a\x80\xff\xff\xff\x38\0\0\n\xfd\0\0\x2\x91\0\0\0\x8c\0\0\0\xc1\0\0\x3\x2\0\0\x2\xd1\0\0\0\0\x2\0\0\0\x2\xd0\0\0\a\x80\xff\xff\xff\x38\0\0\n\xfd\0\0\x2\x91)

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x3\xa2\0\0\x3\xe1\0\0\0\0\0\0\0\0\0\0\x3\xbf\0\0\x4\r\0\0\0\x1\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x3\xa2\0\0\x3\xe1)

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';
  
  /*
    qt-color.conf cheat sheet
    active_colors=
      #ff0000ff, 
      #00ff00ff, 
      #0000ffff, - Window Text
      #ffff00ff, 
      #ff00ffff, - Button Background
      #00ffffff, - 
      #ff8000ff, 
      #8000ffff, 
      #80ff00ff, 
      #800000ff, 
      #008000ff, 
      #000080ff, 
      #808000ff, 
      #800080ff, 
      #008080ff, 
      #ffa500ff, 
      #40e0d0ff, 
      #ff69b4ff, 
      #dc143cff, 
      #000000ff, 
      #ffffffff, 
      #a020f0ff
  
  */
}