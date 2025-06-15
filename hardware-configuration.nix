{ config, lib, pkgs, modulesPath, ... }: {
	# Import Nix modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	# Boot settings
  boot = {
		kernelModules = [ "kvm-intel" ];
  	extraModulePackages = [ ];
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
			kernelModules = [ ];
		};
	};

	# Enable DHCP on each ethernet and wireless interface
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

	# Platform and CPU microcode
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
