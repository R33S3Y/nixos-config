
{ config, pkgs, specialArgs, ... }:

{
  # Set your time zone.
  time.timeZone = config.var.${specialArgs.system}.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.var.${specialArgs.system}.defaultLocale;

  i18n.extraLocaleSettings = config.var.${specialArgs.system}.extraLocaleSettings;
}
