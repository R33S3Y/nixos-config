{
  config,
  ...
}:

{
  # Networking
  networking.hostName = config.system.hosts.${config.system.host}.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${config.system.hosts.${config.system.host}.static.interface}.ipv4.addresses =
    [
      {
        address = config.system.hosts.${config.system.host}.static.ipv4.address;
        prefixLength = config.system.hosts.${config.system.host}.static.ipv4.prefixLength;
      }
    ];
  networking.defaultGateway = {
    address = config.system.hosts.${config.system.host}.static.gatewayAddress;
    interface = config.system.hosts.${config.system.host}.static.interface;
  };
  networking.nameservers = config.system.hosts.${config.system.host}.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
