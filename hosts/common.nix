{ config, pkgs, ... }:
{
  imports = [

    ../common-nix/boot.nix

    ../common-nix/nix.nix
    ../common-nix/local.nix

    ../common-nix/networking.nix
    ../common-nix/print.nix
    ../common-nix/bluetooth.nix
    ../common-nix/sound.nix

    ../common-nix/users.nix

    ../common-nix/desktop.nix
    ../common-nix/x11.nix

    ../common-nix/nas.nix
    ../common-nix/programs.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];
}
