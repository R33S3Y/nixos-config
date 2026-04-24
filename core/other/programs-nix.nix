{ config, pkgs, ... }:

{
  environment.systemPackages = config.system.hosts.${config.system.host}.programs;
}
