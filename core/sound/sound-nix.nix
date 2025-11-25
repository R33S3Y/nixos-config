
{ config, pkgs, specialArgs, ... }:

{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  
  hardware.bluetooth.enable = specialArgs.var.${specialArgs.system}.bluetooth; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = specialArgs.var.${specialArgs.system}.bluetooth; # powers up the default Bluetooth controller on boot
}
