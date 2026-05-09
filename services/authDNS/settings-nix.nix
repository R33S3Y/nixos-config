{ system, ... }:
{
  services.authDNS.domains.${system.networks.${system.network}.public.domain} = {
    primaryNameserver = {
      name = system.hosts.${system.host}.hostName;
      address = system.networks.${system.network}.public.ipv4Address;
    };
    records = [
      {
        name = "${system.hosts.${system.host}.hostName}2";
        type = "A";
        value = system.networks.${system.network}.public.ipv4Address;
      }
      {
        name = "@";
        type = "NS";
        value = "${system.hosts.${system.host}.hostName}2";
      }
    ];
  };
}
