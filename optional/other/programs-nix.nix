
{ config, pkgs, inputs, specialArgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = specialArgs.hosts.${specialArgs.host}.programs;
} 