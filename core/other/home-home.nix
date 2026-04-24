{
  specialArgs,
  lib,
  ...
}:
{


  imports = specialArgs.hosts.${specialArgs.host}.homeImports;
  # Enable home-manager
  config.programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  config.home = {
    stateVersion = "24.11";
    username = specialArgs.users.${specialArgs.user}.name;
    homeDirectory = "/home/${specialArgs.users.${specialArgs.user}.name}";
  };

}
