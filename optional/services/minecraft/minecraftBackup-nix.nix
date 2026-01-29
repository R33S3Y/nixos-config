{ config, pkgs, ... }:

let
  serverName = "cmsSurvival";
  stateDir   = "/srv/minecraft/${serverName}";
  backupDir  = "/mnt/lapisLazuli/cms/backups/${serverName}";
in {
  systemd = {
    services."minecraft-backup-${serverName}" = {
      name = "minecraft-backup-${serverName}";
      description = "Minecraft backup for ${serverName}";
      wants = [ "network-online.target" ];
      after = [
        "network-online.target"
        "minecraft-server-${serverName}.service"
        "mnt-lapisLazuli.mount"
      ];

      serviceConfig = {
        Type = "oneshot";
        User = "cms";
        Group = "cms";
      };

      script = ''
        set -e

        TS=$(date +%F_%H-%M)
        mkdir -p "${backupDir}"

        echo "Stopping Minecraft server..."
        systemctl stop minecraft-server-${serverName}

        echo "Creating backup..."
        ${pkgs.gnutar}/bin/tar \
        --exclude=mods \
        --exclude=libraries \
        -C "${stateDir}" \
        -czf "${backupDir}/${serverName}-$TS.tar.gz" .

        echo "Starting Minecraft server..."
        systemctl start minecraft-server-${serverName}

        echo "Backup finished"
      '';
    };
    timers."minecraft-backup-${serverName}" = {
      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnCalendar = "04:00";
        RandomizedDelaySec = "10m";
        Persistent = true;
        Unit = "minecraft-backup-${serverName}.service";
      };
    };
  };
}
