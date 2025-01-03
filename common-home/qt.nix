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
    active_colors=#ff0000ff, #00ff00ff, #0000ffff, #ffff00ff, #ff00ffff, #00ffffff, #ff8000ff, #8000ffff, #80ff00ff, #800000ff, #008000ff, #000080ff, #808000ff, #800080ff, #008080ff, #ffa500ff, #40e0d0ff, #ff69b4ff, #dc143cff, #000000ff, #ffffffff, #a020f0ff
    disabled_colors=#ff4500ff, #2e8b57ff, #1e90ffff, #ffd700ff, #da70d6ff, #7fffd4ff, #ffa07aff, #d3d3d3ff, #c0c0c0ff, #696969ff, #708090ff, #4682b4ff, #d2691eff, #bc8f8fff, #ff7f50ff, #ff6347ff, #8a2be2ff, #5f9ea0ff, #6b8e23ff, #ffb6c1ff, #ffdeadff, #ff1493ff
    inactive_colors=#7cfc00ff, #7b68eeff, #ff00bfff, #ffa500ff, #da70d6ff, #ff4500ff, #ba55d3ff, #20b2aaff, #32cd32ff, #191970ff, #8b0000ff, #4b0082ff, #ff8c00ff, #008b8bff, #ff1493ff, #dcdcdcff, #d8bfd8ff, #00fa9aff, #ff4500ff, #1e90ffff, #9400d3ff, #ffd700ff
  '';
}