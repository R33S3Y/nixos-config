
{ config, pkgs, ... }:

{
  # make boots pretty
  boot.plymouth.enable = true; # themes are handled by stylix
  stylix.targets.plymouth.logoAnimated = false;

  
  boot.loader.grub.splashImage = config.stylix.image;
  
  #boot.loader.timeout = 0;
}
