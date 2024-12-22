{ config, pkgs, ... }:
{
  home-manager.users.reese = {
    home.stateVersion = "23.05";

    home.programs.zsh.enable = true;
  };
}

