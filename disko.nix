# Disko manages the all the drives when installing NixOS e.g. partitioning
{ device ? throw "Set this to your disk device e.g. '/dev/sda'", ... }: {
  disko.devices.disk.main = {
    # Primary disk config - Holds the system
    primary = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # Boot partition - MUST BE FAT32
					boot = {
						name = "boot";
						size = "1M";
						type = "EF02";
					};
          esp = {
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
}
