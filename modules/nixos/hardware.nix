{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options = {
    graphics = {
      enable = lib.mkEnableOption "Enable graphics drivers";
      enable32Bit = lib.mkEnableOption "Enable 32-bit graphics drivers";
      enableIntel = lib.mkEnableOption "Enable Intel GPU support";
      enableAmd = lib.mkEnableOption "Enable AMD GPU support";
      enableNvidia = lib.mkEnableOption "Enables Nvidia GPU support";
    };
  };

  # Configuration
  config = lib.mkMerge [
    # Graphics
    {
      hardware.graphics = {
        enable = lib.mkIf config.graphics.enable true;
        enable32Bit = lib.mkIf config.graphics.enable32Bit true;
      };
    }

    # Intel GPU support
    (lib.mkIf (config.graphics.enable && config.graphics.enableIntel) {
      # Drivers
      hardware.graphics.extraPackages = with pkgs; [
        # vaapiIntel				# For Intel Gen7 or older (Sandy/Ivy/Haswell)
        intel-media-driver # For Intel Gen8+ (Broadwell and newer)
        vpl-gpu-rt # For Intel Gen9+ (Skylake and newer)
      ];
    })

    # AMD GPU support
    (lib.mkIf (config.graphics.enable && config.graphics.enableAmd) {
      # Environment variables
      environment.variables = {
        # Force Mesa RADV drivers when possible since AMDVLK could have noticeable performance issues
        AMD_VULKAN_ICD = "RADV";

        # Re-enable OpenCL for Polaris-based cards
        ROC_ENABLE_PRE_VEGA = "1";
      };

      # Drivers
      hardware.graphics = {
        extraPackages = with pkgs; [
          amdvlk
          rocmPackages.clr.icd # OpenCL
        ];
        extraPackages32 = lib.mkIf config.graphics.enable32Bit (with pkgs; [
          driversi686Linux.amdvlk
        ]);
      };

      # Linux AMDGPU Controller (LACT) - Allows overclocking, undervolting and setting fans curves of AMD GPUs
      environment.systemPackages = [pkgs.lact];
      systemd = {
        packages = [pkgs.lact];
        services.lactd.wantedBy = ["multi-user.target"];
      };
    })

    # Nvidia GPU support
    (lib.mkIf (config.graphics.enable && config.graphics.enableNvidia) {
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
