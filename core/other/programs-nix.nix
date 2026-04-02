
{ config, pkgs, ... }:

{ 
  environment.systemPackages = specialArgs.hosts.${specialArgs.host}.programs;
}
