{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		enableIntel = lib.mkEnableOption "Enables Intel hardware support";
		enableNvidia = lib.mkEnableOption "Enables Nvidia hardware support";
	};

	# Configuration
	config.hardware = {
		bluetooth.enable = true;

		# Enable all firmware regardless of license and support for most hardware
		enableAllFirmware = true;
		enableAllHardware = true;

		# Graphics
		graphics = {
			enable = true;
			enable32Bit = true;
			extraPackages = with pkgs; []
			++(if config.enableIntel then (
				with pkgs; [
					# vaapiIntel						# For Intel Gen7 or older (Sandy/Ivy/Haswell)
					intel-media-driver			# For Intel Gen8+ (Broadwell and newer)
					vpl-gpu-rt  						# For Intel Gen9+ (Skylake and newer)
				]
			) else []);
		};

		# Nvidia - Look into `https://nixos.wiki/wiki/Nvidia` for further information
		nvidia = lib.mkIf config.enableNVidia {
			modesetting.enable = true;	# REQUIRED
			nvidiaSettings = true;			# Settings menu accessible via `nvidia-settings`

			# You may need to select the appropriate driver version for your specific GPU
			package = config.boot.kernelPackages.nvidiaPackages.stable;

			# Power management - Experimental and can cause sleep/suspend to fail
			# Enable if you have graphical corruption issues or app crashes after waking from sleep
			powerManagement.enable = false;

			# Fine-grained power management - Turns off the GPU when not in use
			# Experimental and only works on modern Nvidia GPUs (Turing or newer)
			powerManagement.finegrained = false;

			# Whether to use open source drivers or not (Not referring to `nouveau`)
			# Supported GPUs: `https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus`
			# Only available from driver 515.43.04+
			open = false;
		};
	};
}
