{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

	# Module options
	options = {
    enableSpotify = lib.mkEnableOption "Enables Spotify";
    enableNcmpcpp = lib.mkEnableOption "Enables NCMPCPP";
  };

	# Configure Spotify if it's enabled
	config = {
    # Services
    services = lib.mkIf config.enableNcmpcpp {
      # Music Player Daemon (MPD) - A free and open-source music player server (Required for NCMPCPP)
      mpd = {
        enable = true;
        musicDirectory = "$XDG_MUSIC_DIR";
        playlistDirectory = "\${dataDir}/playlists";
        dataDir = "$XDG_DATA_HOME/mpd";
        dbFile = "\${dataDir}/tag_cache";
        extraArgs = [ ];
        extraConfig = ''
        '';
      };
      mpd-discord-rpc = {
        enable = true;
        settings = {
          format = {
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

      # MPDris2 - MPD to MPRIS2 bridge
      mpdris2 = {
        enable = true;
        multimediaKeys = false;
        notifications = false;
      };
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
      ncmpcpp = {
        enable = true;
        settings = {};
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
