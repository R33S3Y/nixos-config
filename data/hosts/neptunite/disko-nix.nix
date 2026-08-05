{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/usb-USB_SanDisk_3.2Gen1_03023520022426184724-0:0"; # find with: ls -l /dev/disk/by-id/ | grep sda
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
