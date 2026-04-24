{ pkgs, config, ... }:

{
  services.journald = {
    extraConfig = ''
      SystemMaxUse=2G
      SystemKeepFree=500M
    '';
  };
}
