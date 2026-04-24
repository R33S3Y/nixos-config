{ system, ... }:
{
  stylix = {
    enable = true;

    polarity = system.themes.${system.theme}.polarity;

    image = system.themes.${system.theme}.image;

    base16Scheme = system.themes.${system.theme}.base16Scheme;

    fonts = system.themes.${system.theme}.fonts;
  };
}
