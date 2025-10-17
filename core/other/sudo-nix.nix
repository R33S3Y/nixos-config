
{ config, pkgs, ... }:

{
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    }];
  }, {
    users = [ "rebuild" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    }];
  }];
}


