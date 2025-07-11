{ ... }: {
	# Application launcher
	# Don't let Stylix style Wofi
	stylix.targets.wofi.enable = false;

	# Wofi configuration
	programs.wofi = {
		enable = true;
		style = ''${builtins.readFile ./style.css}'';
		settings = {
			mode = "drun";
			allow_images = true;
			image_size = 32;
			width = 440;
			height = 240;
		};
	};
}
