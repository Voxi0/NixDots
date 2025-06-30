{ lib, config, username, ... }: {
	# Module options
	options.enableVirtualization = lib.mkEnableOption "Enable virtualization support";

	# Configuration
	config = lib.mkIf config.enableVirtualization {
		# Add user to the proper groups for KVM and all
		users.users.${username}.extraGroups = [ "kvm" "libvirtd" ];

		# Abstraction layer to manage virtual machines
		virtualisation.libvirtd.enable = true;
	};
}
