
{ config, pkgs, ... }:

{ 

  var.screenshotFolder = "~/Pictures";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reese = {
    isNormalUser = true;
    description = "reese";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
}
