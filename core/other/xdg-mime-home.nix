{ config, pkgs, ... }:

{
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "inode/directory" = "pcmanfm.desktop";
        };
    };
} 
