
{ config, pkgs, specialArgs, ... }:

{
  # Set your time zone.
  time.timeZone = specialArgs.var.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = specialArgs.var.defaultLocale;

  i18n.extraLocaleSettings = specialArgs.var.extraLocaleSettings;
}
