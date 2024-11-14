# Disko manages the all the drives when installing NixOS e.g. partitioning
{ device ? throw "Set this to your disk device e.g. '/dev/sda'", ... }: {
  disko.devices.disk = {
    # Primary disk config - Holds the system
    primary = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # Boot partition
          esp = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
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
