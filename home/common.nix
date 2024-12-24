{ config, pkgs, ... }:
{
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  home.username = "reese";

  # Nicely reload system units when changing configs
  #systemd.user.startServices = "sd-switch";

  
}

