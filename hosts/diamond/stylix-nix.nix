{ config, pkgs, ... }:
{
  stylix.enable = true;

  stylix.polarity = "dark";

  stylix.image = ./wallpapers/diamond.jpg;

  stylix.base16Scheme = {
    base00 = "181B28"; # ----
    base01 = "282b38"; # ---
    base02 = "383b48"; # --
    base03 = "484b58"; # -
    base04 = "c58bcf"; # +
    base05 = "d5abdf"; # ++
    base06 = "e5cbef"; # +++
    base07 = "f5ebff"; # ++++
    base08 = "4075dc"; # red
    base09 = "5075dc"; # orange
    base0A = "6075dc"; # yellow
    base0B = "7075dc"; # green
    base0C = "8075dc"; # aqua/cyan
    base0D = "9075dc"; # blue
    base0E = "a075dc"; # purple
    base0F = "b075dc"; # brown
  };
  
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrains Mono Nerd Font";
    };
    sansSerif = {
      package = pkgs.source-sans-pro;
      name = "Source Sans Pro";
    };
    serif = config.stylix.fonts.sansSerif;
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
    sizes = {
      applications = 13;
      desktop = 13;
      popups = 13;
      terminal = 13;
    };
  };
}
#base00 = "#181B28"; # ----
#base01 = "#282b38"; # ---
#base02 = "#383b48"; # --
#base03 = "#484b58"; # -
#base04 = "#c58bcf"; # +
#base05 = "#d5abdf"; # ++
#base06 = "#e5cbef"; # +++
#base07 = "#f5ebff"; # ++++
#base08 = "#4075dc"; # red
#base09 = "#5075dc"; # orange
#base0A = "#6075dc"; # yellow
#base0B = "#7075dc"; # green
#base0C = "#8075dc"; # aqua/cyan
#base0D = "#9075dc"; # blue
#base0E = "#a075dc"; # purple
#base0F = "#b075dc"; # brown