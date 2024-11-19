#!/bin/bash
set -e
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"

git push https://github.com/R33S3Y/nixos.git Diamond
