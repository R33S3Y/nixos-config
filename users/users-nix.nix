
{ config, pkgs, ... }:

let username = config.var.username;
in {

  config.var = {
    username = "reese"; # Change Me!!
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username} account";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
}