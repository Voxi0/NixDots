{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		enableSpotify = lib.mkEnableOption "Enables Spotify";
	};

	# Configure Spotify if it's enabled
	config = lib.mkIf config.enableSpotify {
		programs.spotify-player = {
			enable = true;
			package = pkgs.spotify-player;
		};
	};
}
