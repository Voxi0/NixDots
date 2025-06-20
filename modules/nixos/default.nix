_: {
	# Import Nix modules
	imports = [
		./hardware.nix ./services.nix ./programs.nix
		./stylix.nix ./desktops/hyprland ./fish.nix ./gaming.nix
	];
}
