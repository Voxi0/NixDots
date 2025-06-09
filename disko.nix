# Declarative disk partitioning and formatting using Nix
{ device ? throw "Set this to your disk device e.g. `dev/sda`", ... }: {
  disko.devices.disk = {
    # Primary disk config - Where the OS will be installed
    primary = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # Boot partition
          esp = {
            type = "EF00";
            size = "1G";
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
