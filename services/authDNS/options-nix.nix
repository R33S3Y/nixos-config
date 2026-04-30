{ lib, ... }:

# this file defines / lays out the format used to config services.authDNS across this repo
# Hopefully one day we will run our own options searcher that can read this. :3

let
  domainsOpts =
    { name, ... }:
    {
      options = {
        records = lib.mkOption {
          type = lib.types.listOf (lib.types.submodule recordsOpts);
          default = [ ];
          description = ''
            A list of all domain records to be added to the zone file.
          '';
          example = [
            {
              type = "A";
              name = "subdomain";
              value = "1.2.3.4";
            }
            {
              type = "TXT";
              name = "_dmarc";
              value = "v=DMARC1; p=none; rua=mailto:dmarc_agg@vali.email;";
            }
          ];
        };
        email = lib.mkOption {
          type = lib.types.str;
          default = "admin@${name}";
          description = ''
            The email address to go on the address SOA (Start Of Authority)
            Defaults to admin@domainName
          '';
          example = "admin@example.com";
        };
        ttl = lib.mkOption {
          type = lib.types.ints.unsigned;
          default = 3600;
          description = ''
            The TTL or time to live of the domain. It's also used to calculate the time related values for now.
          '';
        };
      };
    };
  recordsOpts =
    { ... }:
    {
      options = {
        type = lib.mkOption {
          type = lib.types.str;
          description = ''
            The dns record type (Most commonly A, AAAA, MX, CNAME & TXT).
          '';
          example = "A";
        };
        name = lib.mkOption {
          type = lib.types.str;
          description = ''
            The name of the record (normally doubles as the subdomain).
          '';
          example = "subdomain";
        };
        value = lib.mkOption {
          type = lib.types.str;
          description = ''
            The value of the record (normally A ip address for A and AAAA type records).
          '';
          example = "1.2.3.4";
        };
      };
    };
in
{
  options.services.authDNS = {
    domains = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule domainsOpts);
      default = { };
      description = ''
        A attrset of all domains that this server is authoritative for.
      '';
      example = {
        "example.com" = {
          records = [ ];
        };
      };
    };
  };
}
