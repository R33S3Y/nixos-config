
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "obsidain"; 
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  users = {
    users.obsidain = {
      isNormalUser = true;
      description = "obsidain";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}  
 