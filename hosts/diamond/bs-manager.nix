
{ config, pkgs, ... }:

{
  services.flatpak.enable = true;
  system.activationScripts.bs-manager.text = ''
    export PATH=${pkgs.flatpak}/bin:$PATH

    # Ensure Flathub is added
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Check if BSManager is already installed
    if ! flatpak list | grep -q 'BSManager'; then
      flatpak install -y https://github.com/Zagrios/bs-manager/releases/download/v1.5.1/BSManager-1.5.1-x86_64.flatpak
    else
      echo "BSManager is already installed. Skipping..."
    fi
  '';
  
}