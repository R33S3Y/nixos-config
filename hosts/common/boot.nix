
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # make boots pretty
  boot.plymouth.enable = true; # themes are handled by stylix
  stylix.targets.plymouth.logoAnimated = false;
  
  boot.loader.timeout = 0;
}
