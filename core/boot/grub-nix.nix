
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}