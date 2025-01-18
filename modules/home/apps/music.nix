{ lib, config, inputs, pkgs, username, ... }: {
  # Import Nix modules
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

	# Module options
	options = {
    enableSpotify = lib.mkEnableOption "Enables Spotify";
    enableNcmpcpp = lib.mkEnableOption "Enables NCMPCPP";
  };

	# Configure enabled music players
	config = {
    # Services
    services = lib.mkIf config.enableNcmpcpp {
      # Music Player Daemon (MPD) - A free and open-source music player server (Required for NCMPCPP)
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

      # Discord rich presence for MPD - Shows what you're listening to etc.
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

      # MPDris2 - MPD to MPRIS2 bridge
      mpdris2 = {
        enable = true;
        multimediaKeys = true;
        notifications = false;
      };
    };

    # Programs
    stylix.targets.cava.rainbow.enable = true;
    programs = {
      # Spicetify - Powerful CLI tool to take control of the Spotify client
      spicetify = lib.mkIf config.enableSpotify {
        enable = true;
        enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
          adblock
          autoSkipVideo
          playlistIcons
          betterGenres
          beautifulLyrics
          hidePodcasts
          shuffle
        ];
      };

      # NCMPCPP - Featureful Ncurses based MPD client inspired by NCMPC
      ncmpcpp = {
        enable = true;
        package = pkgs.ncmpcpp.override {
          outputsSupport = true;
          taglibSupport = true;
          clockSupport = true;
          visualizerSupport = true;
        };
        settings = {
          # Music visualizer
          visualizer_data_source = "/tmp/mpd.fifo";
          visualizer_output_name = "my_fifo";
          visualizer_in_stereo = true;
          visualizer_type = "spectrum";
          visualizer_spectrum_smooth_look = true;
          visualizer_spectrum_smooth_look_legacy_chars = false;
          visualizer_look = "+|";
          visualizer_fps = 60;
          visualizer_autoscale = true;
        };
        bindings = [
          # VIM navigation
          { key = "j"; command = "scroll_down"; }
          { key = "k"; command = "scroll_up"; }
          { key = "J"; command = [ "select_item" "scroll_down" ]; }
          { key = "K"; command = [ "select_item" "scroll_up" ]; }
        ];
      };
    };
  };
}
