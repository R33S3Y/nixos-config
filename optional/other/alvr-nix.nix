
{ config, pkgs, ... }:

{
  programs.alvr = {
    # Pin to 20.13.0 due to https://github.com/alvr-org/ALVR/issues/3134
    package = pkgs.alvr.overrideAttrs (
      finalAttrs: prevAttrs: {
        version = "20.13.0";

        src = pkgs.fetchFromGitHub {
          owner = "alvr-org";
          repo = "ALVR";
          tag = "v${finalAttrs.version}";
          fetchSubmodules = true;
          hash = "sha256-h7/fuuolxbNkjUbqXZ7NTb1AEaDMFaGv/S05faO2HIc=";
        };

        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit (finalAttrs) src;
          hash = "sha256-A0ADPMhsREH1C/xpSxW4W2u4ziDrKRrQyY5kBDn//gQ=";
        };
      }
    );
  };

  networking.firewall.allowedUDPPorts = [ 9943 9944 ];
}