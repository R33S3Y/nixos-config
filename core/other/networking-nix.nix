
{ config, pkgs, ... }:

{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = false;
  networking.firewall.enable = true;

  networking.useDHCP = false;
  networking.interfaces.enp10.ipv4.addresses = [{
    address = "192.168.1.245";
    prefixLength = 24;
  }];
  networking.defaultGateway = {
    address = "192.168.1.1";
    interface = "ens18";
  };
  networking.nameservers = [ "192.168.1.1" ];
}
