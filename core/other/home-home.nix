{ config, ... }:
{

  #imports = config.system.hosts.${config.system.host}.homeImports;
  # Enable home-manager
  config.programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  #config.home = {
  #  stateVersion = "24.11";
  #  username = config.system.users.${config.system.user}.name;
  #  homeDirectory = "/home/${config.system.users.${config.system.user}.name}";
  #};

}
