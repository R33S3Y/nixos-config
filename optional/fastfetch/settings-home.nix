{ config, pkgs, ... }:
{
  # Run fastfetch on system startup
  programs.bash = {
    enable = true;
    
    bashrcExtra = ''
      # Only run fastfetch for interactive, non-SSH shells
      if [[ $- == *i* && -z "$SSH_CONNECTION" ]]; then
        fastfetch
      fi
    '';
  };
}
