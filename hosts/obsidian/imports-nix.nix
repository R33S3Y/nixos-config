{ config, pkgs, specialArgs, ... }:
{
  imports = config.var.${specialArgs.system}.imports;
}
