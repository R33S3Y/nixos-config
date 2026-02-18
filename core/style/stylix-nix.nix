{ config, pkgs, lib, specialArgs,... }:
{
  stylix = {
    enable = true;
    
    polarity = specialArgs.themes.${specialArgs.theme}.polarity;
    
    image = specialArgs.themes.${specialArgs.theme}.wallpaper;
    
    base16Scheme = specialArgs.themes.${specialArgs.theme}.base16Scheme;
  
    fonts = specialArgs.themes.${specialArgs.theme}.fonts;
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