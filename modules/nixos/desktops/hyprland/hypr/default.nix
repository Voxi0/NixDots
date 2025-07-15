_: {
	# Import Nix modules
	imports = [
		./envVars.nix		# Environment variables
		./autostart.nix	# Autostart applications
		./input.nix			# Configure input devices
		./keybinds.nix	# Keybindings
		./looks.nix			# Window decoration and animations
		./windows.nix		# Window rules and layouts
	];
}
