{ lib, config, ... }: {
	# Import Nix modules
	imports = [
		./pipewire.nix	# Pipewire for audio
		./xserver.nix		# Xserver/Xorg/X11 display server
		./bluetooth.nix	# Bluetooth - Accesses `hardware` to enable Bluetooth and `services` for the Bluetooth manager
		./laptop.nix		# Laptop support services e.g. Upower for power management
	];

	# Module options
	options = {
		enableSSH = lib.mkEnableOption "Enable OpenSSH";
		enablePrinting = lib.mkEnableOption "Enable printing support";
		enableFingerprint = lib.mkEnableOption "Enable fingerprint support";
	};

	# Services
  services = {
    udisks2.enable = true;																		# For automatically mounting removable drives
		openssh.enable = lib.mkIf config.enableSSH true;					# Suite of secure networking utilities
		printing.enable = lib.mkIf config.enablePrinting true;		# CUPS for printing
		fprintd.enable = lib.mkIf config.enableFingerprint true;	# Fingerprint daemon to support consumer fingerprint reader devices
  };
}
