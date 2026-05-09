{ system, ... }:
{
  services.authDNS.domains."reesey.org".records = [
    {
      name = "java";
      type = "A";
      value = system.networks.${system.network}.public.ipv4Address;
    }
  ];
}
