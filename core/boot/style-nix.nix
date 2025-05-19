
{ config, pkgs, ... }:

{
  # make boots pretty
  boot.plymouth.enable = true; # themes are handled by stylix
  stylix.targets.plymouth.logoAnimated = false;

  stylix.targets.grub.enable = false;
  boot.loader.grub.splashImage = config.stylix.image;
  
  environment.systemPackages = with pkgs; [
    inkscape
  ];
  #boot.loader.timeout = 0;
}
