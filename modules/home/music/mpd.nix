{ lib, config, pkgs, username, ... }: {
	# Module options
	options.enableMPD = lib.mkEnableOption "Enable Music Player Daemon (MPD)";

	# Configuration
	config = lib.mkIf config.enableMPD {
		# MPD scrobbler - Sends scrobbling information to scrobbling services e.g. LastFM
		home.packages = [ pkgs.mpdscribble ];

		# Services
    services = {
			mpd-mpris.enable = true;	# Required for Playerctl to work

			# Music Player Daemon (MPD) - Free and open-source music player server
      mpd = {
        enable = true;
        musicDirectory = "/home/${username}/Music";
        network = {
          startWhenNeeded = true;
          listenAddress = "any";
        };
        extraArgs = [ ];
        extraConfig = ''
          # Audio outputs
          audio_output {
            type "pipewire"
            name "PipeWire Output"
          }
          audio_output {
            type "fifo"
            name "my_fifo"
            path "/tmp/mpd.fifo"
            format "44100:16:2"
          }
        '';
      };

      # Discord rich presence for MPD
      mpd-discord-rpc = {
        enable = true;
        settings.format = {
          large_image = "notes";
          large_text = "";
          small_image = "notes";
          small_text = "";
          details = "$title";
          state = "On $album by $artist";
          timestamp = "elapsed";
        };
      };
    };
	};
}
