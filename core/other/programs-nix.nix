{
  config,
  pkgs,
  system,
  ...
}:

{
  environment.systemPackages = system.hosts.${system.host}.programs;
}
