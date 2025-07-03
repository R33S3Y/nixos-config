
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
  ];

  nixpkgs.config.allowUnfree = true;
}
 