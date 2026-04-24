{ config, ... }:
{
  stylix = {
    enable = true;

    polarity = config.system.themes.${config.system.theme}.polarity;

    image = config.system.themes.${config.system.theme}.image;

    base16Scheme = config.system.themes.${config.system.theme}.base16Scheme;

    fonts = config.system.themes.${config.system.theme}.fonts;
  };
}
