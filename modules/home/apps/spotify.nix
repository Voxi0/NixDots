{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

	# Module options
	options = {
		enableSpotify = lib.mkEnableOption "Enables Spotify";
	};

	# Configure Spotify if it's enabled
	config = lib.mkIf config.enableSpotify {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
    };
	};
}
