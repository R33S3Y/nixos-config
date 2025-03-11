
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.breeze-icons  # Install Breeze icon theme
  ];

  #gtk.iconTheme = {
  #  package = pkgs.breeze-icons;  
  #  name = "Breeze";  
  #};
}
