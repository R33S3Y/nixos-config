
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "obsidian"; 
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  users = {
    users.obsidian = {
      isNormalUser = true;
      description = "obsidian";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}  
 