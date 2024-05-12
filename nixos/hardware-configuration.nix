# Do Not Modify This File Unless You Know What You're Doing
{ config, lib, pkgs, modulesPath, ... }: {
  # Import Nix Modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Kernel Modules
  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ ];
  };
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # Filesystems - Boot and Root Partitions
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/21BC-DA88";
    fsType = "vfat";
	options = [ "fmask=0022" "dmask=0022" ];
  };
  fileSystems."/" = {
	device = "/dev/disk/by-uuid/f71671c0-80aa-4e65-9928-0088f593931e";
	fsType = "ext4";
  };

  # Swap - Disabled
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  # Host Platform CPU
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
