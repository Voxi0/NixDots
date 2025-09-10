_: {
  # Import Nix modules
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Enable/Disable system modules
  # Core
  enableNetworking = true;
  enablePlymouth = false;
  enableVirtualization = true;
  graphics = {
    enable = true;
    enable32Bit = false;
    enableIntel = false;
    enableAmd = true;
    enableNvidia = false;
  };

  # Services
  enableSystem76Scheduler = true;
  enableLaptopSupport = false;
  enableX11 = false;
  enablePipewire = true;
  enableBluetooth = true;
  enableSSH = true;
  enablePrinting = false;
  enableFingerprint = false;

  # Gaming
  gaming = {
    enableSteam = true;
    enableRoblox = true;
  };

  # ALSO ENABLE THIS OPTION IN HOME MANAGER IF YOU ENABLE ANY OF THESE
  enableFish = true;
  desktops.enableHyprland = true;
}
