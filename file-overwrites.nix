
{ config, pkgs, ... }:
{
  xdg.configFile.".gtkrc-2.0".force = true;
  xdg.configFile.".config/gtk-3.0/gtk.css".force = true;
  xdg.configFile.".config/gtk-3.0/settings.ini".force = true;
  xdg.configFile.".config/gtk-4.0/gtk.css".force = true;
  xdg.configFile.".config/gtk-4.0/settings.ini".force = true;
}
