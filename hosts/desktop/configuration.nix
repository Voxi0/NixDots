_: {
  # Import Nix modules
  imports = [
		./hardware-configuration.nix
		./../../modules/nixos
	];

	# Enable/Disable system modules
	enableGraphics = true;
	enableGraphics32Bit = true;
	enableNetworking = true;
	enableXdgPortals = true;
	enableStylix = true;
  enableFish = true;
	enableVirtualization = true;
  gaming = {
    enable = true;
    enableSteam = true;
    enableRoblox = true;
    enableLutris = false;
    enableHeroic = false;
  };

	# Hardware
	enableIntel = true;
	enableNvidia = false;

	# Services
	enableX11 = false;
	enableAudio = true;
	enableBluetooth = true;
	enableLaptopSupport = false;
	enableSSH = true;
	enablePrinting = false;
	enableFingerprint = false;
}
