{ system, ... }:

{
  environment.systemPackages =
    if system.hosts.${system.host} ? programs then system.hosts.${system.host}.programs else [ ];
}
