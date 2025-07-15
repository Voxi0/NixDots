{ lib, config, ... }: {
	#############################
	### ENVIRONMENT VARIABLES ###
	#############################
	wayland.windowManager.hyprland.settings.env = [
		# Set to "1" if the cursor keeps disappearing
		"WLR_NO_HARDWARE_CURSORS,0"

		# Use Wayland
		"NIXOS_OZONE_WL,1"
		"QT_QPA_PLATFORM,wayland"
		"GTK_USE_PORTAL,1"
		"MOZ_ENABLE_WAYLAND,1"
		"GDK_BACKEND,wayland"
		"SDL_VIDEODRIVER,wayland"
	];
}
