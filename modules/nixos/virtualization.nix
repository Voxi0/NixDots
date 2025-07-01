{ lib, config, username, ... }: {
	# Module options
	options.enableVirtualization = lib.mkEnableOption "Enable virtualization support";

	# Configuration
	config = lib.mkIf config.enableVirtualization {
		# Add user to the proper groups for KVM and all
		users.users.${username}.extraGroups = [ "kvm" "libvirtd" ];

		# Virtualization
		virtualisation = {
			libvirtd.enable = true;	# Abstraction layer to manage virtual machines
			vmVariant.virtualisation = {
				graphics = true;			# Run QEMU with a graphics window
				cores = 2;						# Number of cores the guest is permitted to use
			};
		};
	};
}
