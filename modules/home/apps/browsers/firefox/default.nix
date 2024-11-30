{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableFirefox = lib.mkEnableOption "Enables Firefox";
  };

  # Configure Firefox if it's enabled
  config = lib.mkIf config.enableFirefox {
    # Firefox configuration
    programs.firefox = {
      enable = true;
			package = pkgs.firefox;
      profiles."NixDots" = {
        isDefault = true;

        # Browser settings
        settings = {
          "browser.fullscreen.autohide" = false;
          "ui.key.menuAccessKeyFocuses" = false;
					"toolkit.legacyUserProfileCustomizations.stylesheets" = true;		# For User Chrome CSS
        };

        # Search engines
        search = {
          force = true;
          engines = {
            "Nixpkgs" = {
              urls = [{
								template = "https://search.nixos.org/packages";
								params = [
									{ name = "type"; value = "packages"; }
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];

							icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
							definedAliases = [ "@np" ];
						};
					};
				};

				# User Chrome CSS
				userChrome = ''${builtins.readFile ./userchrome.css}'';
      };
    };
  };
}
