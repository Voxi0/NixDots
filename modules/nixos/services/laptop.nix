# Laptop support services e.g. libinput for touchpads and Upower for power management
{ lib, config, ... }: {
	# Module options
	options.enableLaptopSupport = lib.mkEnableOption "Enable laptop support services e.g. Upower for power management";

	# Configuration
	config.services = lib.mkIf config.enableLaptopSupport {
		# Touchpad support
		libinput.enable = true;

		# Abstraction layer for power management used by applications
    upower = {
      enable = true;
      usePercentageForPolicy = true; # Use battery percentage rather than time left
      percentageAction = 2;
      percentageCritical = 5;
      percentageLow = 10;
      allowRiskyCriticalPowerAction = false;
      criticalPowerAction = "PowerOff";
    };
	};
}
