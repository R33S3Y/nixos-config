{
  lib,
  config,
  pkgs,
  ...
}:
let
  zones =
    domains:
    lib.mapAttrsToList (
      name: info:
      pkgs.stdenv.mkDerivation {
        name = "${name}.zone";
        pname = "${name}.zone";
        version = "1.0";

        src = null;
        dontUnpack = true;

        buildPhase = ''
          echo "
          $ORIGIN ${name}.
          $TTL ${toString info.ttl}

          @ IN SOA ns1.${name}. ${lib.strings.replaceString "@" "." info.email}. (
            $(date +%s)                 ; serial (version number)
            ${toString info.ttl}      ; refresh (how often should the secondary server contact main)
            ${toString (info.ttl / 2)}  ; retry (how long should the secondary server wait before try to contact the primary server in the case of failure)
            ${toString (info.ttl * 16)} ; expire (If the secondary fails to connect to the primary for this amount of time. It should stop serving requests.)
            ${toString info.ttl}      ; minimum
          )

          @   IN NS ns1.${name}.

          ${lib.concatStrings (
            lib.map (record: "${record.name} IN ${record.type} ${record.value} \n") info.records
          )}
          " >> ${name}.zone
        '';

        installPhase = ''
          mkdir -p $out
          cp ${name}.zone $out
        '';
      }
    ) config.services.authDNS.domains;
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

      zone = lib.mapAttrs (name: drv: {
        domain = name;
        storage = drv;
        file = "${name}.zone";
      }) zones;

      log = {
        target = "syslog";
        any = "info";
      };
    };
  };
}
