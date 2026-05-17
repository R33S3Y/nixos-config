{ config, ... }:

{
  programs.vesktop.enable = true;
  stylix.targets.vesktop = {
    colors = {
      enable = true;
      override = {
        base00 = config.stylix.base16Scheme.base01;
        base01 = config.stylix.base16Scheme.base00;
      };
    };
    fonts.enable = true;
  };
}
