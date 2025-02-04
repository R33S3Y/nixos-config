
{ config, pkgs, ... }:

{
  services.flatpak.enable = true;
  system.activationScripts.bs-manager.text = ''
    export PATH=${pkgs.flatpak}/bin:${pkgs.wget}/bin:$PATH

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Download the .flatpak file if not already present
    FILE="/tmp/BSManager-1.5.1-x86_64.flatpak"
    if [ ! -f "$FILE" ]; then
      wget -O "$FILE" https://github.com/Zagrios/bs-manager/releases/download/v1.5.1/BSManager-1.5.1-x86_64.flatpak
    fi

    # Install if not already installed
    if ! flatpak list | grep -q 'bsmanager'; then
      flatpak install -y "$FILE"
    else
      echo "BSManager is already installed. Skipping..."
    fi
  '';
}