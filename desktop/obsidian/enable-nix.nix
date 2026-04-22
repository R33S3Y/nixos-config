{ pkgs, specialArgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obsidian

    rofi-obsidian
    xdg-utils
  ];

  specialArgs.hosts.${specialArgs.host}.programs = [ pkgs.osu-laser-bin ];
}
