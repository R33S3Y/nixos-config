
{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
}