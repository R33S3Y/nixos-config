{ config, pkgs, lib, specialArgs,... }:
{
  stylix = {
    enable = true;
    
    polarity = specialArgs.themes.${specialArgs.theme}.polarity;
    
    image = specialArgs.themes.${specialArgs.theme}.image;
    
    base16Scheme = specialArgs.themes.${specialArgs.theme}.base16Scheme;
  
    fonts = specialArgs.themes.${specialArgs.theme}.fonts;
  };
}
