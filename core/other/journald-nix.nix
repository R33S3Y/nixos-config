{
  config,
  pkgs,
  system,
  ...
}:

{
  services.journald = {
    extraConfig = ''
      SystemMaxUse=2G
      SystemKeepFree=500M
    '';
  };
}
