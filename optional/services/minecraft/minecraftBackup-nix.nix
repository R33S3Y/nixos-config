{ config, pkgs, ... }:

let
  serverName = "cmsSurvival";
  stateDir   = "/srv/minecraft/${serverName}";
  backupDir  = "/mnt/lapisLazuli/cms/backups";
in {
  systemd = {
    services."minecraft-backup-${serverName}" = {
      enable = true;
      description = "Minecraft backup for ${serverName}";
      wants = [ "network-online.target" ];
      
      conflicts = [ "minecraft-server-${serverName}.service" ];
      before    = [ "minecraft-server-${serverName}.service" ];

      after = [
        "network-online.target"
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

        echo "Creating backup..."
        ${pkgs.gnutar}/bin/tar --exclude=mods --exclude=libraries -C "${stateDir}" -czf "${backupDir}/${serverName}-$TS.tar.gz" .

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
