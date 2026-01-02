
{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      cmsSurvival = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21;

        serverProperties = {
          difficulty = "hard";
          view-distance = 16;
          simulation-distance = 16;
          motd = "§cChristian §9Minecraft §eServer§r§b - Now on nixOS\!\!\!";
          level-name = "Fredy"; # comment this line for it to start working          
        };

        jvmOpts = "-Xms4092M -Xmx4092M";

        symlinks = { 
          #Fetching from the internet
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/M7RXiitG/lithium-fabric-mc1.21-0.13.1.jar"; sha256 = ""; };
            Krypton = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar"; sha256 = ""; };
            C2ME = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/fEWDAK3p/c2me-fabric-mc1.21-0.2.0+alpha.11.109.jar"; sha256 = ""; };
            Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/f2mvlGrg/fabric-carpet-1.21-1.4.147+v240613.jar"; sha256 = ""; };
            CarpetExtra = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VX3TgwQh/versions/8gEVsK18/carpet-extra-1.21-1.4.148.jar"; sha256 = ""; };
            TextileBackup = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wwcspvkr/versions/C73KkDD6/textile_backup-3.1.3-1.21.jar"; sha256 = ""; };
            FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/oGwyXeEI/fabric-api-0.102.0+1.21.jar"; sha256 = ""; };
            ClothConfigAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/HpMb5wGb/cloth-config-15.0.140-fabric.jar"; sha256 = ""; };
            Geyzer = pkgs.fetchurl { url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/fabric"; sha256 = ""; };
            Floodgate = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/wPa1pHZJ/Floodgate-Fabric-2.2.4-b36.jar"; sha256 = ""; };
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