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
  enablePlymouth = false;
  enableVirtualization = true;
  gaming = {
    enable = true;
    enableSteam = true;
    enableRoblox = true;
    enableLutris = true;
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

  # ALSO ENABLE THIS OPTION IN HOME MANAGER IF YOU ENABLE ANY OF THESE
  enableFish = true;
  desktops.enableHyprland = true;
}
