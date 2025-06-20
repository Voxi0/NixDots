{ inputs, lib, config, ... }: {
	# Import Nix modules
	imports = [ inputs.ags.homeManagerModules.default ];

	# Module options
	options.enableAGS = lib.mkEnableOption "Enables AGS for widgets";

	# AGS configuration - For widgets and such
	config = lib.mkIf config.enableAGS {
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
	};
}
