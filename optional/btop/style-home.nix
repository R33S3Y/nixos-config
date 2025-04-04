{ config, pkgs, ... }:
{ 
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "stylix";
    };
  };

  home.file."share/btop/themes/stylix.theme".text = ''
    # Was stolen from https://github.com/catppuccin/btop/blob/main/themes/catppuccin_latte.theme
    # Main background, empty for terminal default, need to be empty if you want transparent background
    theme[main_bg]="#${config.stylix.base16Scheme.base00}"

    # Main text color
    theme[main_fg]="#${config.stylix.base16Scheme.base05}"

    # Title color for boxes
    theme[title]="#${config.stylix.base16Scheme.base05}"

    # Highlight color for keyboard shortcuts
    theme[hi_fg]="#${config.stylix.base16Scheme.base0A}"

    # Background color of selected item in processes box
    theme[selected_bg]="#${config.stylix.base16Scheme.base0B}"

    # Foreground color of selected item in processes box
    theme[selected_fg]="#${config.stylix.base16Scheme.base0A}"

    # Color of inactive/disabled text
    theme[inactive_fg]="#${config.stylix.base16Scheme.base01}"

    # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
    theme[graph_text]="#${config.stylix.base16Scheme.base0D}"

    # Background color of the percentage meters
    theme[meter_bg]="#${config.stylix.base16Scheme.base0B}"

    # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
    theme[proc_misc]="#${config.stylix.base16Scheme.base0D}"

    # CPU, Memory, Network, Proc box outline colors
    theme[cpu_box]="#8839ef" #Mauve
    theme[mem_box]="#40a02b" #Green
    theme[net_box]="#e64553" #Maroon
    theme[proc_box]="#${config.stylix.base16Scheme.base0A}" #Blue

    # Box divider line and small boxes line color
    theme[div_line]="#${config.stylix.base16Scheme.base0F}"

    # Temperature graph color (Green -> Yellow -> Red)
    theme[temp_start]="#40a02b"
    theme[temp_mid]="#df8e1d"
    theme[temp_end]="#d20f39"

    # CPU graph colors (Teal -> Lavender)
    theme[cpu_start]="#${config.stylix.base16Scheme.base08}"
    theme[cpu_mid]="#${config.stylix.base16Scheme.base0C}"
    theme[cpu_end]="#${config.stylix.base16Scheme.base0F}"

    # Mem/Disk free meter (Mauve -> Lavender -> Blue)
    theme[free_start]="#8839ef"
    theme[free_mid]="#${config.stylix.base16Scheme.base0B}"
    theme[free_end]="#${config.stylix.base16Scheme.base0A}"

    # Mem/Disk cached meter (Sapphire -> Lavender)
    theme[cached_start]="#${config.stylix.base16Scheme.base09}"
    theme[cached_mid]="#${config.stylix.base16Scheme.base0A}"
    theme[cached_end]="#${config.stylix.base16Scheme.base0B}"

    # Mem/Disk available meter (Peach -> Red)
    theme[available_start]="#fe640b"
    theme[available_mid]="#e64553"
    theme[available_end]="#d20f39"

    # Mem/Disk used meter (Green -> Sky)
    theme[used_start]="#40a02b"
    theme[used_mid]="#${config.stylix.base16Scheme.base08}"
    theme[used_end]="#04a5e5"

    # Download graph colors (Peach -> Red)
    theme[download_start]="#fe640b"
    theme[download_mid]="#e64553"
    theme[download_end]="#d20f39"

    # Upload graph colors (Green -> Sky)
    theme[upload_start]="#40a02b"
    theme[upload_mid]="#${config.stylix.base16Scheme.base08}"
    theme[upload_end]="#04a5e5"

    # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
    theme[process_start]="#${config.stylix.base16Scheme.base09}"
    theme[process_mid]="#${config.stylix.base16Scheme.base0B}"
    theme[process_end]="#8839ef"
  '';
}
