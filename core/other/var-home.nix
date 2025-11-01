# this imported by both home and nix
{ config, pkgs, lib, ... }:

{
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}

