{ config, pkgs, specialArgs, ... }:
{
  imports = specialArgs.var.${specialArgs.system}.homeImports;
  # Enable home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  home.username = "reese";
  home.homeDirectory = "/home/reese";

}

