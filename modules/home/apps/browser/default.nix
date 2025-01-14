{ lib, config, pkgs, ... }: {
	# Module options
	options.enableFirefox = lib.mkEnableOption "Enables Firefox Browser";

	# Configure the browser if it's enabled
	config = lib.mkIf config.enableFirefox {
    programs.firefox = {
      enable = true;
      enableGnomeExtensions = false;
      languagePacks = [ "en-GB" "en-US" ];
      
      # Policies
      policies = {
				BlockAboutConfig = false;
				DefaultDownloadDirectory = "\${home}/Downloads";
			};

      # Default profile
      profiles."NixDots" = {
				name = "NixDots";
        isDefault = true;

        # Style and settings
        userChrome = "${builtins.readFile ./userChrome.css}";
				settings = {
					"ui.key.menuAccessKeyFocuses" = false;  # Stop the 'Alt' key from toggling the menu
					"browser.fullscreen.autohide" = false;  # Don't hide the tab bar when fullscreen
				};

        # Useful extensions to be installed by default with browser
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          sidebery              # Vertical tabs - REQUIRED
          ublock-origin         # Very efficient and lightweight ad blocker
          darkreader            # For reading sites that are too bright
        ];
			};
    };
	};
}
