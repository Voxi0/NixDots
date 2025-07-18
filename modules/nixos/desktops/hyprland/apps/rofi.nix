{ pkgs, ... }: {
	# A window switcher, application launcher and dmenu replacement 
	programs.rofi = {
		enable = true;
		terminal = "${pkgs.kitty}/bin/kitty";
		modes = [ drun emoji ];
		location = "center";
	};
}
