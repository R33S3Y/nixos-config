
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unixtools.netstat #log info about ports with sudo netstat -tulpn
    dig #send test dns trafic Eg dig @1.1.1.1 example.com
  ];
}