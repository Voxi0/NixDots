_: {
  # Import Nix modules
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Enable/Disable system modules
  # Hardware
  enableIntel = true;
  enableAmd = false;
  enableNvidia = false;

  # Core
  enableGraphics = true;
  enableGraphics32Bit = true;
  enableNetworking = true;
  enablePlymouth = false;
  enableVirtualization = true;

  # Services
  enableSystem76Scheduler = true;
  enableLaptopSupport = false;
  enableX11 = false;
  enablePipewire = true;
  enableBluetooth = true;
  enableSSH = true;
  enablePrinting = false;
  enableFingerprint = false;
  enableBongocat = true;

  # Gaming
  gaming = {
    enable = true;
    enableSteam = true;
    enableRoblox = true;
  };

  # ALSO ENABLE THIS OPTION IN HOME MANAGER IF YOU ENABLE ANY OF THESE
  enableFish = true;
  desktops.enableHyprland = true;
}
