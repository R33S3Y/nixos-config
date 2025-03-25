{ config, pkgs, ... }:

{
    home-manager.users.reese = {
        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "inode/directory" = "pcmanfm.desktop";
            };
        };
    };
}
