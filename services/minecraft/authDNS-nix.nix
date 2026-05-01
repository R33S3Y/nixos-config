{ ... }:
{
  services.authDNS.domains."reesey.org".records = [
    {
      name = "java";
      type = "A";
      value = "1.2.3.4";
    }
  ];
}
