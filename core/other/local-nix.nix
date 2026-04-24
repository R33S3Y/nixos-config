{
  config,
  pkgs,
  config,
  ...
}:

{
  # Set your time zone.
  time.timeZone = config.system.users.${config.system.user}.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.system.users.${config.system.user}.defaultLocale;

  i18n.extraLocaleSettings = config.system.users.${config.system.user}.extraLocaleSettings;
}
