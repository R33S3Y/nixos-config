
{ config, pkgs, ... }:

{
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    },{
      command = "/run/current-system/sw/bin/pihole";
      options = [ "NOPASSWD" ];
    }];
  }];
}


