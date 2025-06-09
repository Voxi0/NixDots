{ config, lib, pkgs, modulesPath, ... }: {
	# Import Nix modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	# Boot settings
	boot = {
		kernelModules = [ "kvm-intel" ];
  	extraModulePackages = [ ];
  	initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
			kernelModules = [ ];
		};
	};

	# Swap devices and filesystems
	swapDevices = [ ];
	 fileSystems = {
		# Boot partition
		"/boot" = {
			device = "/dev/disk/by-uuid/4D6E-97C6";
	     fsType = "vfat";
	     options = [ "fmask=0077" "dmask=0077" ];
	   };

		# Root partition
		"/" = {
			device = "/dev/disk/by-uuid/aaff2dac-e0c7-48d8-a80e-a5e9c257c8ba";
	     fsType = "ext4";
	   };
	};

	# Enable DHCP on each ehternet and wireless interface
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

	# Platform and CPU
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
