
{ config, pkgs, ... }:

{
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}

