{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          force = true;
          default = "DuckDuckGo";
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [ 
          ublock-origin
          darkreader
          mtab
        ];
      };
    };
  };
}
