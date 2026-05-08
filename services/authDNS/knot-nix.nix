{
  lib,
  config,
  pkgs,
  ...
}:
let
  findPackage =
    pkgs: name:
    let
      found = builtins.filter (p: p.pname or p.name or "" == name) pkgs;
    in
    if found == [ ] then null else builtins.head found;
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

      zone = lib.mapAttrs (name: info: {
        domain = name;
        storage = "${findPackage config.environment.systemPackages "${name}.zone"}/${name}.zone";
        file = "${name}.zone";
      }) config.services.authDNS.domains;

      log = {
        target = "syslog";
        any = "info";
      };
    };
  };
}
