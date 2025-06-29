{ lib, config, pkgs, username, ... }: {
	# Module options
	options.enableNcmpcpp = lib.mkEnableOption "Enable NCMPCPP (MPD client - CLI music player)";

	# Configuration
	config = lib.mkIf config.enableNcmpcpp && lib.mkIf config.enableMPD {
		# NCMPCPP - Featureful Ncurses based MPD client (Music player)
		programs.ncmpcpp = {
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
}
