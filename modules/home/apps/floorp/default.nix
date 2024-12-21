{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		enableFloorp = lib.mkEnableOption "Enables Floorp Browser";
	};

	# Configure Floorp browser if it's enabled
	config = lib.mkIf config.enableFloorp {
		programs.floorp = {
			enable = true;
			package = pkgs.floorp;
			enableGnomeExtensions = false;
			languagePacks = [ "en-GB" "en-US" ];
			policies = {
				BlockAboutConfig = false;
				DefaultDownloadDirectory = "\${home}/Downloads";
			};
			profiles."NixDots" = {
				name = "NixDots";
				id = 0;
				isDefault = true;
        userChrome = "${builtins.readFile ./userChrome.css}";
				settings = {
					# Make sure the 'Alt' key doesn't bring up that weird menu at the top of the browser
					# I'm using that key as my mod key in my window manager configuration because of my weird keyboard
					# Pressing the mod key brings up this weird menu and it's annoying
					"ui.key.menuAccessKeyFocuses" = false;

					# Don't hide the tab bar thingy when Floorp is fullscreen
					"browser.fullscreen.autohide" = false;

					# Set these variables to the default values that Firefox sets
					# Floorp turns these values up which means the scroll speed is way higher than default Firefox
					# The speed is too high for me and just annoying
					"mousewheel.default.delta_multiplier_y" = "100";
					"mousewheel.min_line_scroll_amount" = "5";
					"general.smoothScroll.currentVelocityWeighting" = "0.25";

					# Homepage for the browser
					# "browser.startup.homepage" = "https://nixos.org";
				};
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          sidebery
          ublock-origin
          darkreader
        ];
			};
		};
	};
}
