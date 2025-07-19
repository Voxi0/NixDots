{
  lib,
  config,
  inputs,
  ...
}: {
  # Import Nix modules
  imports = [inputs.auto-cpufreq.nixosModules.default];

  # Module options
  options.enableLaptopSupport = lib.mkEnableOption "Enable laptop support e.g. battery optimizations";

  # Configuration
  config = lib.mkIf config.enableLaptopSupport {
    # Tool provided by Intel to run diagnostics and analyze power consumption to give suggestions
    # Apply said suggestions with TLP and auto-cpufreq, use powertop only for analyzing
    powerManagement.powertop.enable = true;

    services = {
      libinput.enable = true; # Touchpad support
      thermald.enable = true; # Temperature management daemon

      # Forcefully disable this because it interferes with TLP and isn't required here
      power-profiles-daemon.enable = lib.mkForce false;

      # For optimizing laptop battery life
      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "none";
          CPU_SCALING_GOVERNOR_ON_BAT = "none";
          CPU_ENERGY_PERF_POLICY_ON_AC = "default";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "default";
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 1;
        };
      };

      # Abstraction layer for power management used by applications
      upower = {
        enable = true;
        usePercentageForPolicy = true; # Use battery percentage rather than time left
        percentageAction = 2;
        percentageCritical = 5;
        percentageLow = 10;
        allowRiskyCriticalPowerAction = false;
        criticalPowerAction = "PowerOff";
      };
    };

    # Automatic CPU speed & power optimizer
    programs.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
  };
}
