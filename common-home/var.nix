
{ config, pkgs, ... }:
{
  home.sessionVariables = {
    XDG_CONFIG_HOME = "/home/reese/.config";
  };
}