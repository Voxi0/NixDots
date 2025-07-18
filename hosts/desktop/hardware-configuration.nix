# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  # Import Nix modules
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Boot
  boot = {
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = [];
    };
  };

  # Filesystems and swap
  swapDevices = [];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b5f65ba8-c40f-4ea7-a2e3-19caf8d6a962";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7080-9C9E";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # Platform and CPU
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
