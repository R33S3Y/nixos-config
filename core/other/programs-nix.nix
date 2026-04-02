
{ config, pkgs, specialArgs, ... }:

{ 
  environment.systemPackages = specialArgs.hosts.${specialArgs.host}.programs;
}
