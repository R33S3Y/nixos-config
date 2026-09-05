{ ... }:

{
  services.journald.settings.Journal = {
    SystemMaxUse = "2G";
    SystemKeepFree = "500M";
  };
}
