{ config, lib, pkgs, ... }: {
	# Module options
	options = {
		enableObsidian = lib.mkEnableOption "Enables Obsidian";
	};

	# Configure Obsidian (A note taking software) if enabled
	config = lib.mkIf config.enableObsidian {
		# There's no module to configure Obsidian, so only thing we can do is install it
		home.packages = [ pkgs.obsidian ];
	};
}
