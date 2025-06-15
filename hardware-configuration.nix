{ config, lib, pkgs, modulesPath, ... }: {
	# Import Nix modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	# Boot
	boot = {
		kernelModules = [ "kvm-intel" ];
  	extraModulePackages = [ ];
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  		kernelModules = [ ];
		};
	};

	# Filesystems
	swapDevices = [ ];
  fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/32df0168-5e1c-40c4-854b-46668af44a6a";
			fsType = "ext4";
		};

  	"/boot" = {
			device = "/dev/disk/by-uuid/9FA3-43B4";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
	};

  # Enables DHCP on each ethernet and wireless interface
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

	# Host platform and CPU microcode
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
