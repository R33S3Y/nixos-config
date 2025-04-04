{ config, pkgs, ... }:
{ 
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "stylix";
    }
  }

  home.file."share/btop/themes/stylix.theme".text = ''
    # Was stolen from https://github.com/catppuccin/btop/blob/main/themes/catppuccin_latte.theme
    # Main background, empty for terminal default, need to be empty if you want transparent background
    theme[main_bg]="#eff1f5"

    # Main text color
    theme[main_fg]="#4c4f69"

    # Title color for boxes
    theme[title]="#4c4f69"

    # Highlight color for keyboard shortcuts
    theme[hi_fg]="#1e66f5"

    # Background color of selected item in processes box
    theme[selected_bg]="#bcc0cc"

    # Foreground color of selected item in processes box
    theme[selected_fg]="#1e66f5"

    # Color of inactive/disabled text
    theme[inactive_fg]="#8c8fa1"

    # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
    theme[graph_text]="#dc8a78"

    # Background color of the percentage meters
    theme[meter_bg]="#bcc0cc"

    # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
    theme[proc_misc]="#dc8a78"

    # CPU, Memory, Network, Proc box outline colors
    theme[cpu_box]="#8839ef" #Mauve
    theme[mem_box]="#40a02b" #Green
    theme[net_box]="#e64553" #Maroon
    theme[proc_box]="#1e66f5" #Blue

    # Box divider line and small boxes line color
    theme[div_line]="#9ca0b0"

    # Temperature graph color (Green -> Yellow -> Red)
    theme[temp_start]="#40a02b"
    theme[temp_mid]="#df8e1d"
    theme[temp_end]="#d20f39"

    # CPU graph colors (Teal -> Lavender)
    theme[cpu_start]="#179299"
    theme[cpu_mid]="#209fb5"
    theme[cpu_end]="#7287fd"

    # Mem/Disk free meter (Mauve -> Lavender -> Blue)
    theme[free_start]="#8839ef"
    theme[free_mid]="#7287fd"
    theme[free_end]="#1e66f5"

    # Mem/Disk cached meter (Sapphire -> Lavender)
    theme[cached_start]="#209fb5"
    theme[cached_mid]="#1e66f5"
    theme[cached_end]="#7287fd"

    # Mem/Disk available meter (Peach -> Red)
    theme[available_start]="#fe640b"
    theme[available_mid]="#e64553"
    theme[available_end]="#d20f39"

    # Mem/Disk used meter (Green -> Sky)
    theme[used_start]="#40a02b"
    theme[used_mid]="#179299"
    theme[used_end]="#04a5e5"

    # Download graph colors (Peach -> Red)
    theme[download_start]="#fe640b"
    theme[download_mid]="#e64553"
    theme[download_end]="#d20f39"

    # Upload graph colors (Green -> Sky)
    theme[upload_start]="#40a02b"
    theme[upload_mid]="#179299"
    theme[upload_end]="#04a5e5"

    # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
    theme[process_start]="#209fb5"
    theme[process_mid]="#7287fd"
    theme[process_end]="#8839ef"
  '';
}
