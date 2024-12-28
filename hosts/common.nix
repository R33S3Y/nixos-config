{ config, pkgs, ... }:
{
  imports = [

    ./common/boot.nix

    ./common/nix.nix
    ./common/local.nix

    ./common/networking.nix
    ./common/print.nix
    ./common/bluetooth.nix
    ./common/sound.nix

    ./common/users.nix

    ./common/desktop.nix
    ./common/x11.nix

    ./common/nas.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];
}
