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
    base0C = "5275b8"; # aqua/cyan
    base0D = "6275b8"; # blue
    base0E = "7275b8"; # purple
    base0F = "8275b8"; # brown
  };
}
