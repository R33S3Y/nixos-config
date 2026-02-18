
{ config, pkgs, specialArgs, ... }:

{
  # Set your time zone.
  time.timeZone = specialArgs.hosts.${specialArgs.host}.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = specialArgs.hosts.${specialArgs.host}.defaultLocale;

  i18n.extraLocaleSettings = specialArgs.hosts.${specialArgs.host}.extraLocaleSettings;
}
