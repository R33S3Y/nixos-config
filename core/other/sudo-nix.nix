
{ config, pkgs, ... }:

{
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "/nix/store/*-nixos-rebuild/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    }];
  }];
}