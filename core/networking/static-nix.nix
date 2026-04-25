{
  config,
  system,
  ...
}:

{
  # Networking
  networking.hostName = system.hosts.${system.host}.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${system.hosts.${system.host}.static.interface}.ipv4.addresses =
    [
      {
        address = system.hosts.${system.host}.static.ipv4.address;
        prefixLength = system.hosts.${system.host}.static.ipv4.prefixLength;
      }
    ];
  networking.defaultGateway = {
    address = system.hosts.${system.host}.static.gatewayAddress;
    interface = system.hosts.${system.host}.static.interface;
  };
  networking.nameservers = system.hosts.${system.host}.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
