{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options = {
    enableGraphics = lib.mkEnableOption "Enable graphics drivers";
    enableGraphics32Bit = lib.mkEnableOption "Enable 32-bit graphics drivers";
    enableIntel = lib.mkEnableOption "Enable Intel GPU support";
    enableAmd = lib.mkEnableOption "Enable AMD GPU support";
    enableNvidia = lib.mkEnableOption "Enables Nvidia GPU support";
  };

  # Configuration
  config = lib.mkMerge [
    # Graphics
    {
      hardware.graphics = lib.mkIf config.enableGraphics {
        enable = true;
        enable32Bit = lib.mkIf config.enableGraphics32Bit true;
      };
    }

    # Enable Intel GPU support
    (lib.mkIf (config.enableGraphics && config.enableIntel) {
      hardware.graphics.extraPackages = with pkgs; [
        # vaapiIntel				# For Intel Gen7 or older (Sandy/Ivy/Haswell)
        intel-media-driver # For Intel Gen8+ (Broadwell and newer)
        vpl-gpu-rt # For Intel Gen9+ (Skylake and newer)
      ];
    })

    # Enable AMD GPU support
    (lib.mkIf (config.enableGraphics && config.enableAmd) {
      # Force Mesa RADV drivers when possible since AMDVLK could have noticeable performance issues
      environment.variables.AMD_VULKAN_ICD = "RADV";
      hardware.graphics = {
        extraPackages = [pkgs.amdvlk];
        extraPackages32 = lib.mkIf config.enableGraphics32Bit [pkgs.driversi686Linux.amdvlk];
      };

      # Linux AMDGPU Controller (LACT) - Allows overclocking, undervolting and setting fans curves of AMD GPUs
      environment.systemPackages = [pkgs.lact];
      systemd = {
        packages = [pkgs.lact];
        services.lactd.wantedBy = ["multi-user.target"];
      };
    })

    # Enable Nvidia GPU support
    (lib.mkIf (config.enableGraphics && config.enableNvidia) {
      boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
      hardware.nvidia = lib.mkIf config.enableNVidia {
        modesetting.enable = true; # REQUIRED
        nvidiaSettings = true; # Settings menu accessible via `nvidia-settings`

        # You may need to select the appropriate driver version for your specific GPU
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        # Power management - Experimental and can cause sleep/suspend to fail
        # Enable if you have graphical corruption issues or app crashes after waking from sleep
        powerManagement.enable = false;

        # Turns off the GPU when not in use
        # Experimental and only works on modern Nvidia GPUs (Turing or newer)
        powerManagement.finegrained = false;

        # Whether to use open source drivers or not (Not referring to `nouveau`)
        # Supported GPUs: `https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus`
        # Only available from driver 515.43.04+
        open = false;
      };
    })
  ];
}
