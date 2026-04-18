{
  specialArgs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = specialArgs.hosts.${specialArgs.host}.monitor;
    };
  };
}
