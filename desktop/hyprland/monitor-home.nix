{
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = config.system.hosts.${config.system.host}.monitor;
    };
  };
}
