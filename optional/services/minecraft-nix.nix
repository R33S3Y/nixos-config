
{ config, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
}