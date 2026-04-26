{ system, lib, ... }:
let
  static = system: {
    useDHCP = false;
    interfaces.${system.hosts.${system.host}.static.interface}.ipv4.addresses = [
      {
        address = system.hosts.${system.host}.static.ipv4.address;
        prefixLength = system.hosts.${system.host}.static.ipv4.prefixLength;
      }
    ];
    defaultGateway = {
      address = system.hosts.${system.host}.static.gatewayAddress;
      interface = system.hosts.${system.host}.static.interface;
    };
    nameservers = system.hosts.${system.host}.static.nameservers;
    networkmanager.enable = false;
  };
  dhcp = system: {
    networkmanager.enable = true;
  };
in
{
  # Networking
  networking = {
    firewall.enable = true;
    hostName = system.hosts.${system.host}.hostName;
  }
  // (
    if
      lib.hasAttrByPath [ "hosts" "${system.host}" "static" "ipv4" ] system
      && system.hosts.${system.host}.static.ipv4 ? address
      && system.hosts.${system.host}.static.ipv4 ? prefixLength
      && system.hosts.${system.host}.static.enable
    then
      static system
    else
      dhcp system
  );
}
