
{ config, pkgs, 
  lib,
  stdenv,
  callPackage,
  nix-update-script,

  buildNpmPackage,
  fetchNpmDeps,
  fetchFromGitHub,
  makeDesktopItem,

  autoPatchelfHook,
  copyDesktopItems,
  makeWrapper,

  electron,
  steam-run-free,
  ...
}:

{
  programs.alvr = {
    enable = true;
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

  # was having some internet throughput issues when using alvr this was the fix
  powerManagement.cpuFreqGovernor = "performance"; 
  boot.kernelParams = [ "amd_pstate=active" "processor.max_cstate=1" "idle=nomwait" ];
  boot.blacklistedKernelModules = [ "r8169" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ r8125 ];
  boot.kernelModules = [ "r8125" ];
}