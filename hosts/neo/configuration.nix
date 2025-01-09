{ systemDisk, inputs, ... }: {
  # Import Nix modules
  imports = [
    ./../../hardware-configuration.nix
		(import ../../disko.nix { device = systemDisk; })
    ./../../modules/nixos
  ];

  # Nix settings
	nix = {
		optimise.automatic = true;
    # auto-optimise-store = true;
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			auto-optimise-store = true;

			# Hyprland cachix - We don't want to compile Hyprland ourselves lol. That would take forever
			substituters = ["https://hyprland.cachix.org"];
			trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
		};
	};

  # Nix packages
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nur.overlays.default
    ];
  };

	# Replace existing files rather than exit with an error
	home-manager.backupFileExtension = "backup";
}
