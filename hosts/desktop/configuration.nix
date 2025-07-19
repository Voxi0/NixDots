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
  enablePlymouth = true;
  enableStylix = true;
  enableFish = true;
  enableVirtualization = true;
  gaming = {
    enable = true;
    enableSteam = true;
    enableRoblox = true;
    enableOsu = true;
    enableOsuLazer = false;
    enableLutris = false;
    enableHeroic = false;
  };

  # Hardware
  enableIntel = true;
  enableAmd = false;
  enableNvidia = false;

  # Services
  enableSystem76Scheduler = true;
  enableX11 = false;
  enablePipewire = true;
  enableBluetooth = true;
  enableLaptopSupport = false;
  enableSSH = true;
  enablePrinting = false;
  enableFingerprint = false;
}
