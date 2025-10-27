
{ config, pkgs, specialArgs, ... }:

{

  # Networking
  networking.hostName = specialArgs.var.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${specialArgs.var.static.interface}.ipv4.addresses = [{
      address = specialArgs.var.static.ipv4.address;
      prefixLength = specialArgs.var.static.ipv4.prefixLength;
    }];
  networking.defaultGateway = {
    address = specialArgs.var.static.gatewayAddress;
    interface = specialArgs.var.static.interface;
  };
  networking.nameservers = specialArgs.var.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
