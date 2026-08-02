{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    man-db
    man-pages
  ];
}
