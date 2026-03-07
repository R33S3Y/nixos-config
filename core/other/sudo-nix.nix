
{ config, pkgs, ... }:

{
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    }];
  } {
    users = [ "rebuild" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    } {
      command = "/run/current-system/sw/bin/nix-env --profile /nix/var/nix/profiles/system --delete-generations +25";
      options = [ "NOPASSWD" ];
    } {
      command = "/run/current-system/sw/bin/nix-collect-garbage";
      options = [ "NOPASSWD" ];
    }];
  }];
}


