{ lib, config, ... }:

let
  args = config._module.args;
in
{
  options.system = {
    hosts = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
    };

    host = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
    };

    users = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
    };

    user = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
    };

    themes = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
    };

    theme = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
    };
  };

  config = {
    system.hosts = args.hosts;
    system.host  = args.host;

    system.users = args.users;
    system.user  = args.user;

    system.themes = args.themes;
    system.theme  = args.theme;
  };
}