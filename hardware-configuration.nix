# Don't modify this file
{ config, lib, pkgs, modulesPath, ... }: {
  # Import Nix modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Boot
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # File systems
  fileSystems = {
    # Boot partition
    "/boot" = {
      device = "/dev/disk/by-uuid/90AD-E06E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    # Root partition
    "/" = {
      device = "/dev/disk/by-uuid/7ea58352-88b4-469d-8f35-d4bd15421241";
      fsType = "ext4";
    };
  };

  # Virtual memory
  swapDevices = [ ];

  # Enable DHCP on each ethernet and wireless interface
  # In case of scripted networking (The default), this is the recommended approach
  # When using systemd-networkd it's still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
