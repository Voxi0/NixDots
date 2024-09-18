# Disko manages the all the drives when installing NixOS e.g. partitioning
{
  disko.devices = {
    disk = {
      # Primary disk config - Holds the system
      primary = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # Boot partition - MUST BE FAT32
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            # Swap partition - Just for safety
            swap = {
              size = "4G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            # Root partition
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
