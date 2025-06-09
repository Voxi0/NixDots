{ lib, config, inputs, pkgs, username, ... }: {
  # Import Nix modules
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

	# Module options
	options = {
    enableSpotify = lib.mkEnableOption "Enable Spotify (Spicetify)";
    enableNcmpcpp = lib.mkEnableOption "Enable NCMPCPP (CLI music player)";
  };

	# Configure enabled music players
	config = {
    # MPD scrobbler - Sends scrobbling information to scrobbling services e.g. LastFM (Required for NCMPCPP)
    home.packages = lib.mkIf config.enableNcmpcpp [ pkgs.mpdscribble ];

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

      # An implementation of the MPRIS protocol for MPD (Required for Playerctl to work)
      mpd-mpris.enable = true;
    };

    # Programs
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
      ncmpcpp = lib.mkIf config.enableNcmpcpp {
        enable = true;
        package = pkgs.ncmpcpp.override {
          outputsSupport = true;
          taglibSupport = true;
          clockSupport = true;
          visualizerSupport = true;
        };
        settings = {
          # UI
          user_interface = "classic";
          titles_visibility = true;
          header_visibility = true;

          # Colors
          colors_enabled = true;
          visualizer_color = "blue";
          volume_color = "green";
          header_window_color = "red";
          state_line_color = "blue";
          state_flags_color = "red";
          main_window_color = "white";
          progressbar_color = "yellow";
          progressbar_elapsed_color = "green";
          statusbar_color = "red";
          empty_tag_color = "yellow";

          # General
          mpd_crossfade_time = 4;
          connected_message_on_startup = false;
          allow_for_physical_item_deletion = true;
          ask_before_clearing_playlists = true;
          ignore_leading_the = true;

          # Mouse Support
          mouse_support = true;
          header_text_scrolling = true;
          cyclic_scrolling = false;
          lines_scrolled = 1;

          # Lyrics
          store_lyrics_in_song_dir = false;
          lyrics_directory = "${config.services.mpd.musicDirectory}/.lyrics";
          fetch_lyrics_for_current_song_in_background = true;
          follow_now_playing_lyrics = true;

          # Going forwards/backwards in song
          seek_time = 5;
          incremental_seeking = false;

          # Information to display
          clock_display_seconds = true;
          display_volume_level = true;
          display_bitrate = false;
          display_remaining_time = false;

          # Display modes
          playlist_display_mode = "classic";

          # Formats
          song_list_format = "{%t} $R {%a | %l}";

          # Progressbar
          progressbar_look = "─|─";

          # Music visualizer
          visualizer_data_source = "/tmp/mpd.fifo";
          visualizer_output_name = "my_fifo";
          visualizer_in_stereo = true;
          visualizer_fps = 120;
          visualizer_autoscale = true;
          visualizer_look = "●▋";
          visualizer_type = "spectrum";
          visualizer_spectrum_smooth_look = true;
          visualizer_spectrum_smooth_look_legacy_chars = false;
          visualizer_spectrum_gain = 0;
          visualizer_spectrum_dft_size = 3;
          visualizer_spectrum_hz_max = 10000;
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
