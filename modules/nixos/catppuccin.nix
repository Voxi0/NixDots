{ lib, config, inputs, pkgs, ... }: {
	# Import Nix modules
	imports = [
		inputs.catppuccin.nixosModules.catppuccin
		inputs.catppuccin.homeManagerModules.catppuccin
	];

	# Module options
	options = {
		enableCatppuccin = lib.mkEnableOption "Enables Catppuccin Theme for NixOS";
	};

	# Enable the catppuccin theme for NixOS if enabled
	config = lib.mkIf config.enableCatppuccin {
		catppuccin = {
			enable = true;
			flavor = "mocha";
			accent = "sapphire";
		};
	};
}
