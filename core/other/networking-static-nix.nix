
{ config, pkgs, ... }:

{

  # Networking
  networking.hostName = config.var.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${config.var.static.interface}.ipv4.addresses = [{
      address = config.var.static.ipv4.address;
      prefixLength = config.var.static.ipv4.prefixLength;
    }];
  networking.defaultGateway = {
    address = config.var.static.gatewayAddress;
    interface = config.var.static.interface;
  };
  networking.nameservers = config.var.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
