_: {
	#############################
	### ENVIRONMENT VARIABLES ###
	#############################
	env = [
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

	#################
	### VARIABLES ###
	#################
	"$mainMod" = "SUPER";
	"$terminal" = "uwsm app -- kitty";
	"$menu" = "uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)";

	# Command to bring up the logout menu
	"$logoutMenuCmd" = "uwsm app -- wlogout";

	# Commands to control volume
	"$increaseVolumeCmd" = "swayosd-client --output-volume +5 --max-volume 100";
	"$decreaseVolumeCmd" = "swayosd-client --output-volume -5 --max-volume 100";
	"$toggleAudioMuteCmd" = "swayosd-client --output-volume mute-toggle";

	# Commands to control screen brightness
	"$increaseBrightnessCmd" = "swayosd-client --brightness +5";
	"$decreaseBrightnessCmd" = "swayosd-client --brightness -5";

	# Commands to use for screenshots - For the entire screen or selected area
	"$fullscreenScreenshotCmd" = "grim";
	"$selectedAreaScreenshotCmd" = ''grim -g "$(slurp)"'';
}
