
{ config, pkgs, ... }:

{
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak install https://github.com/Zagrios/bs-manager/releases/download/v1.5.1/BSManager-1.5.1-x86_64.flatpak
    '';
  };
}