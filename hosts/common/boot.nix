
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # make boots pretty
  # boot.plymouth.enable = true; # themes are handled by stylix
  
  # Enable "Silent Boot" (disable loging)
  # boot.consoleLogLevel = 0;
  # boot.initrd.verbose = false;
  # boot.kernelParams = [
  #    #"quiet"
  #    "splash"
  #    "boot.shell_on_fail"
  #    "loglevel=3"
  #    "rd.systemd.show_status=false"
  #    "rd.udev.log_level=3"
  #    "udev.log_priority=3"
  #  ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
  boot.loader.timeout = 0;
}
