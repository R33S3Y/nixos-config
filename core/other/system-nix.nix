{ lib, specialArgs, ... }:
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
}
