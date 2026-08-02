{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fooyin ];
}
