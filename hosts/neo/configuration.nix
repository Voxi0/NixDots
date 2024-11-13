{ pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./../../hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Nix/Nixpkgs settings
	nixpkgs.config.allowUnfree = true;
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];

		# Hyprland cachix - We don't want to compile Hyprland ourselves lol. That would take forever
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Boot - Use the Liquorix kernel. Suggested by a friend
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_lqx;

	# Replace existing files rather than exit with an error
	home-manager.backupFileExtension = "backup";
}
