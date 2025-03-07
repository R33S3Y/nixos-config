{ config, pkgs, ... }:
{
  # Run fastfetch on system startup
  programs.bash = {
    enable = true;
    
    bashrcExtra = ''
      fastfetch
    '';
  };
}
