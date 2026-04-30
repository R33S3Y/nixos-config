{
  lib,
  config,
  pkgs,
  ...
}:
{
  services.knot = {
    enable = true;
    checkConfig = true;

    settings = {

      server = {
        listen = [
          "0.0.0.0@53"
          "::@53"
        ];
      };

      zone = lib.mapAttrsToList (name: info: {
        domain = name;
        storage = "${pkgs.${"${name}.zone"}}";
        file = "${name}.zone";
      }) config.services.authDNS.domains;

      log = {
        target = "syslog";
        any = "info";
      };
    };
  };
}
