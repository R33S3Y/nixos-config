
{ config, pkgs, specialArgs, ... }:

{

  # Networking
  networking.hostName = config.var.${specialArgs.system}.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${config.var.${specialArgs.system}.static.interface}.ipv4.addresses = [{
      address = config.var.${specialArgs.system}.static.ipv4.address;
      prefixLength = config.var.${specialArgs.system}.static.ipv4.prefixLength;
    }];
  networking.defaultGateway = {
    address = config.var.${specialArgs.system}.static.gatewayAddress;
    interface = config.var.${specialArgs.system}.static.interface;
  };
  networking.nameservers = config.var.${specialArgs.system}.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
