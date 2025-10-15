{ config, pkgs, ... }:
{
  users = {
    users.reese = {
      isNormalUser = true;
      uid = 1000;
      description = "reese";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}