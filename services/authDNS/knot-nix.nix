{
  lib,
  config,
  pkgs,
  ...
}:
let
  zones = lib.mapAttrs (
    name: info:
    pkgs.stdenv.mkDerivation {
      pname = "${name}.zone";
      version = "1.0";
      src = null;
      dontUnpack = true;
      buildPhase = ''
        cat > ${name}.zone <<EOF
        \$ORIGIN ${name}.
        \$TTL ${toString info.ttl}
        @ IN SOA ns1.${name}. ${lib.strings.replaceStrings [ "@" ] [ "." ] info.email}. (
          $(date +%s)                 ; serial
          ${toString info.ttl}        ; refresh
          ${toString (info.ttl / 2)}  ; retry
          ${toString (info.ttl * 16)} ; expire
          ${toString info.ttl}        ; minimum
        )
        @ IN NS ns1.${name}.
        ${lib.concatMapStrings (record: "${record.name} IN ${record.type} ${record.value}\n") info.records}
        EOF
      '';
      installPhase = ''
        mkdir -p $out
        cp ${name}.zone $out/
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
      zone = lib.mapAttrsToList (name: drv: {
        domain = name;
        storage = "${drv}";
        file = "${name}.zone";
      }) zones;
      log = [
        {
          target = "syslog";
          any = "info";
        }
      ];
    };
  };
}
