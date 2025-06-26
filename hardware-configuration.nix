{ config, lib, pkgs, modulesPath, ... }: {
	# Import Nix modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	# Boot
  boot = {
		kernelModules = [ "kvm-intel" ];
		extraModulePackages = [ ];
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  		kernelModules = [ ];
		};
	};

	# Filesystems
	swapDevices = [ ];
  fileSystems = {
		# Boot partition
  	"/boot" = {
			device = "/dev/disk/by-uuid/E223-8C77";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

		# Root partition
		"/" = {
			device = "/dev/disk/by-uuid/a09733a6-f73c-460d-b390-5bd0efd17130";
      fsType = "ext4";
    };
	};

  # Enables DHCP on each ethernet and wireless interface
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

	# Platform and CPU microcode
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
