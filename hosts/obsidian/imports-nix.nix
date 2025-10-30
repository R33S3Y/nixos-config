{ config, pkgs, specialArgs, ... }:
{
  imports = specialArgs.var.${specialArgs.system}.imports;
}
