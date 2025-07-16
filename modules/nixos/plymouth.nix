{ lib, config, pkgs, ... }: {
	# Module options
	options.enablePlymouth = lib.mkEnableOption "Enable Plymouth for a graphical splash screen during boot/poweroff";

	# Configuration
	config = lib.mkIf config.enablePlymouth {
		boot = {
			# Hide OS menu for bootloaders until a key is pressed
    	loader.timeout = 0;

			# Enable "silent" boot
			consoleLogLevel = 3;
			initrd.verbose = false;
			kernelParams = [ "quiet" "splash" "boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto" ];

			# Plymouth
			plymouth = {
				enable = true;
				theme = lib.mkIf (!config.enableStylix) "rings";
				themePackages = lib.mkIf (!config.enableStylix) [(pkgs.adi1090x-plymouth-themes.override {
					selected_themes = [ "rings" ];
				})];
			};
		};
	};
}
