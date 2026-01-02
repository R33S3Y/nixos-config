
{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 
      25565 
    ]; #minecraft java default server port
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;

    user = "cms";
    group = "cms";

    servers = {
      cmsSurvival = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_11;

        serverProperties = {
          difficulty = "hard";
          view-distance = 16;
          simulation-distance = 16;
          motd = "§cChristian §9Minecraft §eServer§r§b - Hi Bort\!\!\!";
          level-name = "Fred";     
        };

        jvmOpts = "-Xms4092M -Xmx4092M";

        symlinks = { 
          #Fetching from the internet
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            #Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/M7RXiitG/lithium-fabric-mc1.21-0.13.1.jar"; sha256 = "sha256-IXYZzj6Xr/eqe46ddY69m4cNVHPUTBsaPLkucCAiDEs="; };
            #Krypton = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar"; sha256 = "sha256-lPGVgZsk5dpk7/3J2hXN2Eg2zHXo/w/QmLq2vC9J4/4="; };
            #C2ME = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/fEWDAK3p/c2me-fabric-mc1.21-0.2.0+alpha.11.109.jar"; sha256 = "sha256-DHdk0FTriRjK26KJLEE4n04QU//Uj3mOZuKlK+Fe4Nw="; };
            #Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/f2mvlGrg/fabric-carpet-1.21-1.4.147+v240613.jar"; sha256 = "sha256-B5/IpOBz6ySwEP/MWI5Z+TuYQUPhfY7xn7sLav8PGdk="; };
            #CarpetExtra = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VX3TgwQh/versions/8gEVsK18/carpet-extra-1.21-1.4.148.jar"; sha256 = "sha256-2EJfekuE+8hX30hhhD/1EfvxwcRFL+m7HrRuBFjY2Ps="; };
            #TextileBackup = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wwcspvkr/versions/C73KkDD6/textile_backup-3.1.3-1.21.jar"; sha256 = "sha256-4i6F8u2bKyzuXZ+UMFbOf7RAhMnqeiUmVI6di68orQ8="; };
            #FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/oGwyXeEI/fabric-api-0.102.0+1.21.jar"; sha256 = "sha256-fsDloR53lX/h7QMoSHkhqCEbt+rOFCmM10Y1vsYaPyY="; };
            #ClothConfigAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/HpMb5wGb/cloth-config-15.0.140-fabric.jar"; sha256 = "sha256-M4lOldo69ZAUs50SZYbVJB4H6jn4YYdj4w2rY3QF+V8="; };
            #Geyzer = pkgs.fetchurl { url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/fabric"; sha256 = ""; };
            #Floodgate = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/wPa1pHZJ/Floodgate-Fabric-2.2.4-b36.jar"; sha256 = "sha256-ifzWrdZ4KJoQpFspdhmOQ+FJtwVMaGtfy4XQOcewV0Y="; };
          });
      
          #"server-icon.png" = /home/reese/server-icon.png;         
          "config/textile_backup.json5" = pkgs.writeTextFile {
            name = "textile_backup.json5";
            text = "{
        'perWorldBackup': true,
        'backupInterval':  86400,
        'restoreDelay': 30,
        'doBackupsOnEmptyServer': false,
        'shutdownBackup': true,
        'backupOldWorlds': true,
        'deleteOldBackupAfterRestore': false,
        'backupsToKeep': 25,
        'broadcastBackupStart': true,
        'broadcastBackupDone': true,
}";
          };
        };
      };
    };
  };
}