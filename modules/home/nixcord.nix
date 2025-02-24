{ inputs, lib, config, ... }: {
  # Import Nix modules
  imports = [ inputs.nixcord.homeManagerModules.nixcord ];

  # Module options
  options.enableNixcord = lib.mkEnableOption "Nixcord (Discord)";

  # Configuration
  config = lib.mkIf config.enableNixcord {
    programs.nixcord = {
			enable = true;
      discord.vencord.unstable = true;

			# quickCss = "";
			config = {
				frameless = false;

				# Use QuickCSS or an online theme
				useQuickCss = false;
				enabledThemes = [];
        themeLinks = [
					"https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/flavors/midnight-catppuccin-mocha.theme.css"
				];

				# Vencord plugins
				plugins = {
					# Essentials
					fakeNitro.enable = true;
					pinDMs.enable = true;
					plainFolderIcon.enable = true;
					platformIndicators.enable = true;
					readAllNotificationsButton.enable = true;
					youtubeAdblock.enable = true;

					# Spotify
					spotifyCrack.enable = true;
					spotifyControls.enable = true;
					spotifyShareCommands.enable = true;

					# Cool
					alwaysAnimate.enable = true;
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
