{ lib, config, pkgs, ... }: {
	# Module options
	options.enableNvidia = lib.mkEnableOption "Enables Nvidia GPU support";

	# Configuration
	config = lib.mkIf (config.enableGraphics && config.enableNvidia) {
		# Required for Hyprland
		boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

		# Look at `https://nixos.wiki/wiki/Nvidia` for further information
		hardware.nvidia = lib.mkIf config.enableNVidia {
			modesetting.enable = true;	# REQUIRED
			nvidiaSettings = true;			# Settings menu accessible via `nvidia-settings`

			# You may need to select the appropriate driver version for your specific GPU
			package = config.boot.kernelPackages.nvidiaPackages.stable;

			# Power management - Experimental and can cause sleep/suspend to fail
			# Enable if you have graphical corruption issues or app crashes after waking from sleep
			powerManagement.enable = false;

			# Turns off the GPU when not in use
			# Experimental and only works on modern Nvidia GPUs (Turing or newer)
			powerManagement.finegrained = false;

			# Whether to use open source drivers or not (Not referring to `nouveau`)
			# Supported GPUs: `https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus`
			# Only available from driver 515.43.04+
			open = false;
		};
	};
}
