{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [ ../../modules/home ];

	# Enable/Disable our custom Home Manager modules
  enableKitty = true;
  enableFirefox = true;
  enableGit = true;
  enableSpotify = true;
	enableMPD = true;
  enableNcmpcpp = true;
	enableDiscord = true;
}
