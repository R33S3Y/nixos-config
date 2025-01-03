{ config, pkgs, ... }:
{
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
  home.file.".config/qt6ct/colors/qt-color.conf".text = ''
    [ColorScheme]
    active_colors=#ffffffff, #ff4242ff, #ff9797ff, #ff5e5cff, #ff302ff, #ff4a49ff, #ffffffff, #ffffffff, #ffffffff, #ff3d3dff, #ff2220ff, #ffe7e4ff, #ff1260ff, #fff9f9ff, #ff0986ff, #ffa70bff, #ff5c5bff, #ffffffff, #ff3f3fff, #ffffffff, #80ffffff, #ff1260ff
    disabled_colors=#ff8080ff, #ff4242ff, #ff9797ff, #ff5e5cff, #ff302fff, #ff4a49ff, #ff8080ff, #ffffffff, #ff8080ff, #ff3d3dff, #ff2220ff, #ffe7e4ff, #ff1260ff, #ff8080ff, #ff0986ff, #ffa70bff, #ff5c5bff, #ffffffff, #ff3f3fff, #ffffffff, #80ffffff, #ff1260ff
    inactive_colors=#ffffffff, #ff424245, #ff9797ff, #ff5e5cff, #ff302fff, #ff4a49ff, #ffffffff, #ffffffff, #ffffffff, #ff3d3dff, #ff2220ff, #ffe7e4ff, #ff1260ff, #fff9f9ff, #ff0986ff, #ffa70bff, #ff5c5bff, #ffffffff, #ff3f3fff, #ffffffff, #80ffffff, #ff1260ff
  '';
}