{ config, pkgs, ... }:

{
  environment.systemPackages = system.hosts.${system.host}.programs;
}
