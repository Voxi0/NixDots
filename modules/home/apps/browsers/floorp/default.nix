{ lib, config, pkgs, ... }: {
	# Module options
	options = {
		floorp.enable = lib.mkEnableOption "Enables Floorp Browser";
	};

	# Configure Floorp browser if enabled
	config = lib.mkIf config.floorp.enable {
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
				extensions = [];
			};
		};
	};
}
