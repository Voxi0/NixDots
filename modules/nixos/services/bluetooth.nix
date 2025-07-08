{ lib, config, ... }: {
	# Module options
	options.enableBluetooth = lib.mkEnableOption "Enable Bluetooth support";

	# Configuration
	config = lib.mkIf config.enableBluetooth {
		# Bluetooth
		hardware.bluetooth = {
			enable = true;
			powerOnBoot = false;
		};

		# Bluetooth manager
		services.blueman.enable = true;
	};
}
