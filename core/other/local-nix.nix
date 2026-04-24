{
  config,
  pkgs,
  system,
  ...
}:

{
  # Set your time zone.
  time.timeZone = system.users.${system.user}.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = system.users.${system.user}.defaultLocale;

  i18n.extraLocaleSettings = system.users.${system.user}.extraLocaleSettings;
}
