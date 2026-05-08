{
  lib,
  config,
  pkgs,
  ...
}:
let
  findPackage = pkgs: name: builtins.head (builtins.filter (p: p.pname or p.name or "" == name) pkgs);
in
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

      zone = lib.mapAttrs (
        name: info:
        let
          zoneName = "${name}.zone";
        in
        {
          domain = name;
          storage = "${findPackage config.environment.systemPackages zoneName}/${zoneName}";
          file = zoneName;
        }
      ) config.services.authDNS.domains;

      log = {
        target = "syslog";
        any = "info";
      };
    };
  };
}
