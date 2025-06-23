{ inputs, pkgs, ... }: {
	# Import Nix modules
	imports = [ inputs.ags.homeManagerModules.default ];

	# AGS configuration - For widgets and such
	programs.ags = {
		enable = true;
		configDir = ../ags-dots;

		# Additional packages to add to GJS's runtime
		extraPackages = with pkgs; [
			gtksourceview accountsservice
		] ++ (with inputs.ags.packages.${pkgs.system}; [
			hyprland powerprofiles battery network wireplumber mpris notifd bluetooth tray
		]);
	};
}
