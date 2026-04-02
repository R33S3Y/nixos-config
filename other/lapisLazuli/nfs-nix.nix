
{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/mnt/lapisLazuli" = {
    device = "lapisLazuli:/mnt/Pool 1/lapisLazuli";
    fsType = "nfs";
  };
} 