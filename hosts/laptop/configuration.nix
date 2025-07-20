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
    enable = false;
    enableSteam = false;
    enableRoblox = false;
    enableLutris = false;
    enableHeroic = false;
  };

  # Hardware
  enableIntel = true;
  enableAmd = false;
  enableNvidia = false;

  # Services
  enableSystem76Scheduler = true;
  enableLaptopSupport = true;
  enableX11 = false;
  enablePipewire = true;
  enableBluetooth = true;
  enableSSH = true;
  enablePrinting = false;
  enableFingerprint = false;
}
