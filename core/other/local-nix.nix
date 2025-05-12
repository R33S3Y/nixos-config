
{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = config.var.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.var.defaultLocale;

  i18n.extraLocaleSettings = config.var.extraLocaleSettings;
}
