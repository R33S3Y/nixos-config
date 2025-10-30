
{ config, pkgs, specialArgs, ... }:

{

  # Networking
  networking.hostName = specialArgs.var.${specialArgs.system}.hostName; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.${specialArgs.var.${specialArgs.system}.static.interface}.ipv4.addresses = [{
      address = specialArgs.var.${specialArgs.system}.static.ipv4.address;
      prefixLength = specialArgs.var.${specialArgs.system}.static.ipv4.prefixLength;
    }];
  networking.defaultGateway = {
    address = specialArgs.var.${specialArgs.system}.static.gatewayAddress;
    interface = specialArgs.var.${specialArgs.system}.static.interface;
  };
  networking.nameservers = specialArgs.var.${specialArgs.system}.static.nameservers;
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;
}
