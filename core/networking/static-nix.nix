
{ config, pkgs, specialArgs, ... }:

{

  # Networking
  networking.hostName = specialArgs.hosts.${specialArgs.host}.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${specialArgs.hosts.${specialArgs.host}.static.interface}.ipv4.addresses = [{
      address = specialArgs.hosts.${specialArgs.host}.static.ipv4.address;
      prefixLength = specialArgs.hosts.${specialArgs.host}.static.ipv4.prefixLength;
    }];
  networking.defaultGateway = {
    address = specialArgs.hosts.${specialArgs.host}.static.gatewayAddress;
    interface = specialArgs.hosts.${specialArgs.host}.static.interface;
  };
  networking.nameservers = specialArgs.hosts.${specialArgs.host}.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
