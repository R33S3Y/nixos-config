
{ config, pkgs, ... }:

{
  #needed to see other disks in file managers
  services.udisks2.enable = true; 
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    pcmanfm
    peazip
  ];
}
