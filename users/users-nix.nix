
{ config, pkgs, ... }:

{ 

  config.var.screenshot-folder = "~/Pictures";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  config.users.users.reese = {
    isNormalUser = true;
    description = "reese";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
}
