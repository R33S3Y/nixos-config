{ config, pkgs, ... }:
let username = config.var.username;
in {
  users = {
    users.${username} = {
      isNormalUser = true;
      uid = 1000;
      description = "${username}";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}