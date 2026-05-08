{ system, ... }:
{
  services.authDNS.domains.${system.networks.${system.network}.public.domain}.primaryNameserver = {
    name = system.hosts.${system.host}.hostName;
    address = system.networks.${system.network}.public.ipV4Address;
  };
}
