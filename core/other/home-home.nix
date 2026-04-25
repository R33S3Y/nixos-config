{ config, users, user, hosts, host, ... }:
{

  imports = hosts.${host}.homeImports;
  # Enable home-manager
  config.programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  config.home = {
    stateVersion = "24.11";
    username = users.${user}.name;
    homeDirectory = "/home/${users.${user}.name}";
  };

}
