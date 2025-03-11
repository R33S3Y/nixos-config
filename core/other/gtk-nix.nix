
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    breeze-icons  # Install Breeze icon theme
  ];

  gtk.iconTheme = {
    package = pkgs.breeze-icons;  
    name = "Breeze";  
  };
}
