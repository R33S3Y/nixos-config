
{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/home/reese/lapisLazuli" = {
    device = "lapisLazuli:/mnt/Pool 1/lapisLazuli";
    fsType = "nfs";
  };
}