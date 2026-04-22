{ pkgs, specialArgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obsidian

    rofi-obsidian
    xdg-utils
  ];

  specialArgs.hosts.${specialArgs.host}.programs = with pkgs; [ osu-laser-bin ];
}
