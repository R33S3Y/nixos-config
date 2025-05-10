{ config, pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;

    # Inject a custom Lua rule to disable the Buds mic
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/main.lua.d/91-disable-galaxybuds-mic.lua" ''
        rule = {
          matches = {
            {
              { "node.name", "matches", "bluez_input.C4:77:64:6C:56:95" }
            }
          },
          apply_properties = {
            ["device.disabled"] = true
          }
        }

        table.insert(bluez_monitor.rules, rule)
      '')
    ];
  };
}

