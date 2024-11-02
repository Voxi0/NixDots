# Don't modify this file - Please make changes to "/etc/nixos/configuration.nix" instead
{ config, lib, modulesPath, ... }: {
  # Import Nix modules
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # Filesystems
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/9351-EFC4";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/d3b72fe6-5176-45b8-bc3e-272c8c9beac0";
      fsType = "ext4";
    };
  };
    
  swapDevices = [
    { device = "/dev/disk/by-uuid/738f4d31-8f0d-4002-ad7a-2d3426705f6f"; }
  ];

  # Enable DHCP on each ethernet and wireless interface
  # In case of scripted networking (the default), this is the recommended approach
  # When using "systemd-networkd" it's still possible to use this option but it's recommended to use it in conjunction
  # with explicit per-interface declarations with "networking.interfaces.<interface>.useDHCP"
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  # Host platform and CPU microcode
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
