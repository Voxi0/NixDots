{ lib, config, inputs, pkgs, ... }: {
	# Import Nix modules
	imports = [
		inputs.nixcord.homeManagerModules.nixcord
	];

  # Module options
  options = {
    enableNixcord = lib.mkEnableOption "Enables Nixcord";
  };

  # Configure Vesktop only if it's enabled
  config = lib.mkIf config.enableNixcord {
		programs.nixcord = {
			enable = true;
			discord = {
				openASAR.enable = true;															# Makes discord faster and includes more features
				vencord = {
					enable = true;
					package = pkgs.vencord;
				};
			};
			# quickCss = "";
			config = {
				frameless = true;

				# Use QuickCSS or an online theme
				useQuickCss = false;
				themeLinks = [];

				# Plugins
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
					alwaysTrust.enable = true;
					noTypingAnimation.enable = true;
					onePingPerDM.enable = true;
					messageLogger.enable = true;
					messageLatency.enable = true;
					callTimer.enable = true;
					friendsSince.enable = true;
					relationshipNotifier.enable = true;
					implicitRelationships.enable = true;
					gifPaste.enable = true;
					customIdle = {
						enable = true;
						remainInIdle = true;														# Remain idle until you confirm to go back online
						idleTimeout = 0.0;
					};

					# More stuff
					petpet.enable = true;
					moreCommands.enable = true;
					moreKaomoji.enable = true;
					webKeybinds.enable = true;

					# Fixes
					fixSpotifyEmbeds.enable = true;
					fixImagesQuality.enable = true;
					webScreenShareFixes.enable = true;
				};
			};

			# Extra JSON config
			extraConfig = {};
		};
  };
}
