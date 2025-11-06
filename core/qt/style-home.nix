{ config, pkgs, lib, ... }:
let
  # Define the content of the file
  qtColorConf = pkgs.writeTextFile {
    name = "qt-color.conf";
    text = ''
      [ColorScheme]
      active_colors=#ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base02}, #ff${config.stylix.base16Scheme.base0F}, #ff${config.stylix.base16Scheme.base0C}, #ff${config.stylix.base16Scheme.base01}, #ff${config.stylix.base16Scheme.base03}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base06}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base0F}, #ff${config.stylix.base16Scheme.base06}, #ff${config.stylix.base16Scheme.base0B}, #ff${config.stylix.base16Scheme.base05}, #ff${config.stylix.base16Scheme.base01}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base03}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base0F}
      disabled_colors=#ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base02}, #ff${config.stylix.base16Scheme.base0F}, #ff${config.stylix.base16Scheme.base0C}, #ff${config.stylix.base16Scheme.base01}, #ff${config.stylix.base16Scheme.base03}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base06}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base0F}, #ff${config.stylix.base16Scheme.base06}, #ff${config.stylix.base16Scheme.base0B}, #ff${config.stylix.base16Scheme.base05}, #ff${config.stylix.base16Scheme.base01}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base03}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base0F}
      inactive_colors=#ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base02}, #ff${config.stylix.base16Scheme.base0F}, #ff${config.stylix.base16Scheme.base0C}, #ff${config.stylix.base16Scheme.base01}, #ff${config.stylix.base16Scheme.base03}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base06}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base0F}, #ff${config.stylix.base16Scheme.base06}, #ff${config.stylix.base16Scheme.base0B}, #ff${config.stylix.base16Scheme.base05}, #ff${config.stylix.base16Scheme.base01}, #ff${config.stylix.base16Scheme.base00}, #ff${config.stylix.base16Scheme.base03}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base07}, #ff${config.stylix.base16Scheme.base0F}
    '';
  };
  qtConf = pkgs.writeTextFile {
    name = "qt6ct.conf";
    text = ''
      [Appearance]
      color_scheme_path=/home/reese/.config/qt6ct/colors/qt-color.conf
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
  };
in {
  home.activation.createQtConf = lib.mkAfter ''
    mkdir -p ${config.home.homeDirectory}/.config/qt6ct/colors
    if [ -f ${config.home.homeDirectory}/.config/qt6ct/colors/qt-color.conf ]; then
      rm ${config.home.homeDirectory}/.config/qt6ct/colors/qt-color.conf
    fi
    cp ${qtColorConf} ${config.home.homeDirectory}/.config/qt6ct/colors/qt-color.conf
    chmod 755 ${config.home.homeDirectory}/.config/qt6ct/colors/qt-color.conf

    mkdir -p ${config.home.homeDirectory}/.config/qt6ct/
    if [ -f ${config.home.homeDirectory}/.config/qt6ct/qt6ct.conf ]; then
      rm ${config.home.homeDirectory}/.config/qt6ct/qt6ct.conf
    fi
    cp ${qtConf} ${config.home.homeDirectory}/.config/qt6ct/qt6ct.conf
    chmod 755 ${config.home.homeDirectory}/.config/qt6ct/qt6ct.conf
  '';

  stylix.targets.qt.enable = false;
}