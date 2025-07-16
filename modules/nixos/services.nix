{ lib, config, kbLayout, pkgs, ... }: {
	# Module options
	options = {
		enableX11 = lib.mkEnableOption "Enable X11 display server";
		enablePipewire = lib.mkEnableOption "Enable Pipewire for audio";
		enableBluetooth = lib.mkEnableOption "Enable Bluetooth support";
		enableLaptopSupport = lib.mkEnableOption "Enable laptop support services e.g. Upower for power management";
		enableSSH = lib.mkEnableOption "Enable OpenSSH";
		enablePrinting = lib.mkEnableOption "Enable printing support";
		enableFingerprint = lib.mkEnableOption "Enable fingerprint support";
	};

	# Services
  config = lib.mkMerge [
		# Handy utilities
		# Suite of secure networking utilities
		(lib.mkIf config.enableSSH {services.openssh.enable = true;})

		# CUPS for printing
		(lib.mkIf config.enablePrinting {services.printing.enable = true;})

		# Fingerprint daemon to support consumer fingerprint readers
		(lib.mkIf config.enableFingerprint {services.fprintd.enable = true;})

		# X11/Xorg windowing system
		(lib.mkIf config.enableX11 {
			services.xserver = {
				enable = true;
				excludePackages = [ pkgs.xterm ];
				videoDrivers = [ ] ++ lib.optional config.enableNvidia "nvidia";
				xkb = {
					layout = kbLayout;
					variant = "";
				};
			};
		})

		# Pipewire for audio
		(lib.mkIf config.enablePipewire {
			environment.systemPackages = [ pkgs.pavucontrol ];
			services = {
				pulseaudio.enable = false;
				pipewire = {
					enable = true;
					wireplumber.enable = true;
					alsa.enable = true;
					alsa.support32Bit = true;
					pulse.enable = true;
					jack.enable = true;
				};
			};
		})

		# Bluetooth manager and hardware config
		(lib.mkIf config.enableBluetooth {
			services.blueman.enable = true;
			hardware.bluetooth = {
				enable = true;
				powerOnBoot = false;
			};
		})

		# Laptop support services e.g. Upower for power management
		(lib.mkIf config.enableLaptopSupport {
			services = {
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
		})
	];
}
