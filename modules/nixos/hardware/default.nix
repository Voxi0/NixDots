{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		enableGraphics = lib.mkEnableOption "Enable graphics drivers";
		enableGraphics32Bit = lib.mkEnableOption "Enable 32-bit graphics drivers";
	};

	# Configuration
	config.hardware = {
		# Graphics
		graphics = lib.mkIf config.enableGraphics {
			enable = true;
			enable32Bit = lib.mkIf config.enableGraphics32Bit true;
		};
	};
}
