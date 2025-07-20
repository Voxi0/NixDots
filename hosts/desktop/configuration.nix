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
  enablePlymouth = false;
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
  enableAmd = false;
  enableNvidia = false;

  # Services
  enableSystem76Scheduler = true;
  enableLaptopSupport = false;
  enableX11 = false;
  enablePipewire = true;
  enableBluetooth = true;
  enableSSH = true;
  enablePrinting = false;
  enableFingerprint = false;
}
