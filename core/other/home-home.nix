{ specialArgs, lib, ... }:
{
  system = {
    hosts = lib.mkOption {
      default = specialArgs.hosts;
      type = lib.types.attrs;
      readOnly = true;
    };
    host = lib.mkOption {
      default = specialArgs.host;
      type = lib.types.str;
      readOnly = true;
    };

    users = lib.mkOption {
      default = specialArgs.users;
      type = lib.types.attrs;
      readOnly = true;
    };
    user = lib.mkOption {
      default = specialArgs.user;
      type = lib.types.str;
      readOnly = true;
    };

    themes = lib.mkOption {
      default = specialArgs.themes;
      type = lib.types.attrs;
      readOnly = true;
    };
    theme = lib.mkOption {
      default = specialArgs.theme;
      type = lib.types.str;
      readOnly = true;
    };
  };

  imports = specialArgs.hosts.${specialArgs.host}.homeImports;
  # Enable home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  home.username = specialArgs.users.${specialArgs.user}.name;
  home.homeDirectory = "/home/${specialArgs.users.${specialArgs.user}.name}";
}
