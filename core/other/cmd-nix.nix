{ pkgs, ... }:

{
  # A place to install some basic CMD tools that are useful but not big enough to need their own file.
  environment.systemPackages = with pkgs; [
    git
    nano
    unixtools.netstat # log info about ports with sudo netstat -tulpn
    dig # send test dns trafic Eg dig @1.1.1.1 example.com
    tcpdump
  ];
}
