{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		enableSpotify = lib.mkEnableOption "Enables Spotify";
	};

	# Configure Spotify if it's enabled
	config = lib.mkIf config.enableSpotify {
		home.packages = [ pkgs.spotube ];
	};
}
