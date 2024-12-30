{ config, pkgs, ... }:
{
  stylix.enable = true;

  stylix.polarity = "dark";

  stylix.image = ../../wallpapers/diamond.jpg;

  stylix.base16Scheme = {
    base00 = "181B28"; # ----
    base01 = "282b38"; # ---
    base02 = "383b48"; # --
    base03 = "484b58"; # -
    base04 = "c58bcf"; # +
    base05 = "d5abdf"; # ++
    base06 = "e5cbef"; # +++
    base07 = "f5ebff"; # ++++
    base08 = "fb4934"; # red
    base09 = "fe8019"; # orange
    base0A = "fabd2f"; # yellow
    base0B = "b8bb26"; # green
    base0C = "8ec07c"; # aqua/cyan
    base0D = "83a598"; # blue
    base0E = "d3869b"; # purple
    base0F = "d65d0e"; # brown
  };
}
