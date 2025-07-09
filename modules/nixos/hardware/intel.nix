{ lib, config, pkgs, ... }: {
	# Module options
	options.enableIntel = lib.mkEnableOption "Enable Intel GPU support";

	# Configuration
	config = lib.mkIf (config.enableGraphics && config.enableIntel) {
		hardware.graphics.extraPackages = with pkgs; [
			# vaapiIntel				# For Intel Gen7 or older (Sandy/Ivy/Haswell)
			intel-media-driver	# For Intel Gen8+ (Broadwell and newer)
			vpl-gpu-rt  				# For Intel Gen9+ (Skylake and newer)
		];
	};
}
