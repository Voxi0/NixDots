{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		enableIntel = lib.mkEnableOption "Enables Intel hardware support";
		enableNVidia = lib.mkEnableOption "Enables NVidia hardware support";
	};

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
					# vaapiIntel				# For Intel Gen7 or older (Sandy/Ivy/Haswell)
					intel-media-driver	# For Intel Gen8+ (Broadwell and newer)
					vpl-gpu-rt  				# For Intel Gen9+ (Skylake and newer)
				]
			) else []);
    };

		# NVidia - Look into `https://nixos.wiki/wiki/Nvidia` for further information
		services.xserver.videoDrivers = lib.mkIf config.enableNVidia [ "nvidia" ];
		hardware.nvidia = lib.mkIf config.enableNVidia {
			# You may need to select the appropriate driver version for your specific GPU
			package = config.boot.kernelPackages.nvidiaPackages.stable;

			# REQUIRED
			modesetting.enable = true;

			# Nvidia power management. Experimental, and can cause sleep/suspend to fail.
			# Enable this if you have graphical corruption issues or application crashes after waking
			# up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
			# of just the bare essentials.
			powerManagement.enable = false;

			# Fine-grained power management - Turns off GPU when not in use
			# Experimental and only works on modern Nvidia GPUs (Turing or newer)
			powerManagement.finegrained = false;

			# Use the NVidia open source kernel module (Not referring to `nouveau`)
			# Supported GPUs: `https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus`
			# Only available from driver 515.43.04+
			open = false;

			# Enable the Nvidia settings menu accessible via `nvidia-settings`
			nvidiaSettings = true;
		};
	};
}
