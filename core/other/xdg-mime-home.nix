{ config, pkgs, ... }:

{
    home-manager = {
        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "inode/directory" = "pcmanfm.desktop";
            };
        };
    };
}
