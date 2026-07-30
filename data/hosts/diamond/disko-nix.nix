{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-CT2000P3SSD8_2404E890C23F"; # find with: ls -l /dev/disk/by-id/ | grep sda
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
