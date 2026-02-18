
{ config, pkgs, specialArgs, ... }:

{
  # Set your time zone.
  time.timeZone = specialArgs.users.${specialArgs.user}.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = specialArgs.users.${specialArgs.user}.defaultLocale;

  i18n.extraLocaleSettings = specialArgs.users.${specialArgs.user}.extraLocaleSettings;
}
