{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;

    bashrcExtra = ''
      fastfetch
    '';
  };
}
