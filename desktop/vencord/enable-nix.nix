{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vencord
  ];
}
