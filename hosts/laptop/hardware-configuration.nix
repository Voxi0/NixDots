{
  config,
  lib,
  modulesPath,
  ...
}: {
  # Import Nix modules
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # Boot
  boot = {
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    initrd = {
      kernelModules = [];
      availableKernelModules = ["xhci_pci" "ahci" "sd_mod" "sr_mod" "rtsx_pci_sdmmc"];
    };
  };

  # Filesystems
  swapDevices = [];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/23b3601a-d9eb-43ba-bf8f-ced40aaea3b7";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/4C11-94AD";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  # Platform and CPU
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
