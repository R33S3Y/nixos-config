{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # For SMB/CIFS
  ];

  fileSystems."${config.system.hosts.${config.system.host}.lapisLazuli.mount}" = {
    device = "//192.168.1.253/${config.system.hosts.${config.system.host}.lapisLazuli.share}";
    fsType = "cifs";
    options = [
      "credentials=${config.system.hosts.${config.system.host}.lapisLazuli.credentials}"
      "uid=${config.system.users.${config.system.user}.name}"
      "gid=users"
      "iocharset=utf8"
    ];
  };
}
