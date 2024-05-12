{ config, ... }: {
  programs.git = {
	# Let Home Manager Install and Manage Git
	enable = true;

	# Set Git User Info
	userName = "Voxi0";
	userEmail = "alif200099@gmail.com";
  };
}
