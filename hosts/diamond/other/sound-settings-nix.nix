{ config, pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;

    # Inject a custom Lua rule to disable the Buds mic
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/91-disable-galaxybuds-mic.lua" ''
        monitor.bluez.rules = [
          {
            matches = [
              {
                node.name = "bluez_input.C4:77:64:6C:56:95"
              }
            ]
            actions = {
              update-props = {
                device.disabled = true
              }
            }
          }
        ]
      '')
    ];
  };
}

