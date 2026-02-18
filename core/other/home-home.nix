{ specialArgs, ... }:
{
  imports = specialArgs.hosts.${specialArgs.host}.homeImports;
  # Enable home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  home.username = specialArgs.users.${specialArgs.user}.name;
  home.homeDirectory = "/home/${specialArgs.users.${specialArgs.user}.name}";

}

