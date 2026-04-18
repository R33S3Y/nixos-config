{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    strawberry
  ];
}
