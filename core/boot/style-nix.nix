
{ config, pkgs, ... }:

{
  # make boots pretty
  boot.plymouth.enable = true; # themes are handled by stylix
  stylix.targets.plymouth.logoAnimated = false;

  stylix.targets.grub.enable = false;
  boot.loader.grub.splashImage = config.stylix.image;
  boot.loader.grub.theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
  
  #boot.loader.timeout = 0;
}
