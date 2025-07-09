_: {
	# Import Nix modules
	imports = [
		./hardware						# Hardware specific configuration e.g. graphics drivers
		./stylix.nix					# System-wide theming and typography
		./users.nix						# Configure user groups and such
		./services						# System services
		./programs.nix				# System programs
		./android.nix					# Android development tools
		./virtualization.nix	# Virtualization stuff e.g. KVM (Kernel-based Virtual Machine)
		./desktops/hyprland		# Desktop environment / Window manager
		./fish.nix						# Fancy shell
		./gaming.nix					# Gaming related stuff
	];
}
