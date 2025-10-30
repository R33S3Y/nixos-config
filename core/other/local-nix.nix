
{ config, pkgs, specialArgs, ... }:

{
  # Set your time zone.
  time.timeZone = specialArgs.var.${specialArgs.system}.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = specialArgs.var.${specialArgs.system}.defaultLocale;

  i18n.extraLocaleSettings = specialArgs.var.${specialArgs.system}.extraLocaleSettings;
}
