{ config, pkgs, lib, ... }:

let
  bsManagerFlatpakUrl = "https://github.com/Zagrios/bs-manager/releases/download/v1.5.0-alpha.7/BSManager-1.5.0-alpha.7-x86_64.flatpak";
in
{
  home.activation.bs-manager = lib.mkAfter ''
    # Define Flatpak package location
    flatpak_file="${config.home.homeDirectory}/BSManager-1.5.0-alpha.7-x86_64.flatpak"

    # Download the Flatpak
    if [ ! -f "$flatpak_file" ]; then
      echo "Downloading BSManager Flatpak..."
      curl -L -o "$flatpak_file" ${bsManagerFlatpakUrl}
    fi

    # Install the Flatpak
    echo "Installing BSManager Flatpak..."
    flatpak install --user --assumeyes "$flatpak_file"

    # Clean up after installation
    if [ $? -eq 0 ]; then
      echo "Cleaning up Flatpak file..."
      rm -f "$flatpak_file"
    else
      echo "Flatpak installation failed."
    fi
  '';
}
