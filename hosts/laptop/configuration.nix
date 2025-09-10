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
    enableIntel = true;
    enableAmd = false;
    enableNvidia = false;
  };

  # Services
  enableSystem76Scheduler = true;
  enableLaptopSupport = true;
  enableX11 = false;
  enablePipewire = true;
  enableBluetooth = true;
  enableSSH = true;
  enablePrinting = false;
  enableFingerprint = false;

  # Gaming
  gaming = {
    enableSteam = false;
    enableRoblox = false;
  };

  # ALSO ENABLE THIS OPTION IN HOME MANAGER IF YOU ENABLE ANY OF THESE
  enableFish = true;
  desktops.enableHyprland = true;
}
