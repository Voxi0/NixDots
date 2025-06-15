{ inputs, lib, config, ... }: {
	# Import Nix modules
	imports = [ inputs.nixcord.homeModules.nixcord ];

	# Module options
	options.enableDiscord = lib.mkEnableOption "Enable Discord";

	# Configuration
	config = lib.mkIf config.enableDiscord {
		programs.nixcord = {
			enable = true;

			# Lightweight alternative to Discord client
			dorion = {
				enable = true;

				# General/System
				openOnStartup = false;
				autoClearCache = true;
      	disableHardwareAccel = false;
				desktopNotifications = true;

				# Appearance
				theme = "dark";
				zoom = "1.1";
				blur = "acrylic";

				# RPC
				rpcServer = true;
				rpcProcessScanner = true;
			};

			# Styling and plugins
			config = {
				# Styles/Themes
				frameless = false;
				useQuickCss = false;
				enabledThemes = [];
				themeLinks = [
					"https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/flavors/midnight-catppuccin-mocha.theme.css"
				];

				# Plugins
				plugins = {
					# Essentials
					fakeNitro.enable = true;
					pinDMs.enable = true;
					plainFolderIcon.enable = true;
					readAllNotificationsButton.enable = true;
					youtubeAdblock.enable = true;

					# Spotify
					spotifyCrack.enable = true;
					spotifyControls.enable = true;
					spotifyShareCommands.enable = true;

					# Cool
          noTypingAnimation.enable = true;
					alwaysTrust.enable = true;
					onePingPerDM.enable = true;
					messageLogger.enable = true;
					friendsSince.enable = true;
					relationshipNotifier.enable = true;
					customIdle = {
						enable = true;
						remainInIdle = true;
						idleTimeout = 0.0;
					};

					# More stuff
					petpet.enable = true;
					webKeybinds.enable = true;

					# Fixes
					fixSpotifyEmbeds.enable = true;
					fixImagesQuality.enable = true;
					webScreenShareFixes.enable = true;
				};
			};
		};
	};
}
