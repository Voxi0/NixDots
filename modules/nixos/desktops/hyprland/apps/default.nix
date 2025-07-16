_: {
  # Import Nix modules
  imports = [
    ./playerctl.nix		# To control media players via commands
		./wofi						# App launcher
		./quickshell.nix	# For widgets
		./swaync.nix			# Sway notification centre
		./wlogout.nix			# Logout menu
  ];
}
