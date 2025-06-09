_: {
	# Import Nix modules
	imports = [
		./hardware.nix ./services.nix ./programs.nix
		./stylix.nix ./fish.nix ./gaming.nix
	];
}
