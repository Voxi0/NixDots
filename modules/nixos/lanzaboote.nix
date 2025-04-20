{ inputs, lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

	# Module options
	options.enableSecureBoot = lib.mkEnableOption "Enables Lanzaboote for secure boot";

	# Configuration
	config = lib.mkIf config.enableSecureBoot {
		# For debugging and troubleshooting secure boot
		environment.systemPackages = [ pkgs.sbctl ];

		# Boot
		boot = {
			loader.systemd-boot.enable = lib.mkForce false;
			lanzaboote = {
				enable = true;
				pkiBundle = "/var/lib/sbctl";
			};
		};
	};
}
