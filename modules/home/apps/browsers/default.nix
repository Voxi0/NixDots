{ lib, ... }: {
	# Import Nix modules
	imports = [
		./firefox ./floorp
	];

	# Enable all browsers by default
	enableFirefox = lib.mkDefault true;
	enableFloorp = lib.mkDefault true;
}
