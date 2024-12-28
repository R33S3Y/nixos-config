
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.plymouth.enable = true; # boot mode img software
  boot.kernelParams = [ "quiet" "splash" ]; # actual make it show up
}
