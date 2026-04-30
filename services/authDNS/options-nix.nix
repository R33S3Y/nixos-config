{ lib, ... }:

# this file defines / lays out the format ysed to config services.authDNS across this repo
# Hopefully one day we will run our own options searcher that can read this. :3

let
  domainsOpts =
    { ... }:
    {
      options.records = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule (recordsOpts));
        default = [ ];
        description = ''
          A list of all domain records to be added to the zone file.
        '';
        example = [
          {
            type = "A";
            name = "subdomain";
            value = "1.2.3.4";
          } {
            type = "TXT";
            name = "_dmarc";
            value = "v=DMARC1; p=none; rua=mailto:dmarc_agg@vali.email;";
          }
        ];
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
          ''
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
      type = lib.types.attrsOf (lib.types.submodule (domainsOpts));
      default = { };
      description = ''
        A attrset of all domains that this server is authoritative for.
      '';
      example = {
        "example.com" = {
          records = [];
        };
      };
    };
  };
}
