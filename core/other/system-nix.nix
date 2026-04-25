{ lib, system, ... }:
{
  options.system = {
    hosts = lib.mkOption {
      default = system.hosts;
      type = lib.types.attrs;
      readOnly = true;
    };
    host = lib.mkOption {
      default = system.host;
      type = lib.types.str;
      readOnly = true;
    };

    users = lib.mkOption {
      default = system.users;
      type = lib.types.attrs;
      readOnly = true;
    };
    user = lib.mkOption {
      default = system.user;
      type = lib.types.str;
      readOnly = true;
    };

    themes = lib.mkOption {
      default = system.themes;
      type = lib.types.attrs;
      readOnly = true;
    };
    theme = lib.mkOption {
      default = system.theme;
      type = lib.types.str;
      readOnly = true;
    };
  };
}
