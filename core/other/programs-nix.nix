{
  config,
  pkgs,
  config,
  ...
}:

{
  environment.systemPackages = config.system.hosts.${config.system.host}.programs;
}
