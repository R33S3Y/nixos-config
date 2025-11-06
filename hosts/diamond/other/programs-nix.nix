
{ config, pkgs, inputs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = specialArgs.var.${specialArgs.system}.programs;
} 