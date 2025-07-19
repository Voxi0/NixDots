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
    # Tool provided by Intel to enable various power-saving modes in user-space, kernel and hardware
    powerManagement.powertop.enable = true;

    services = {
      libinput.enable = true; # Touchpad support
      thermald.enable = true; # Temperature management daemon
      power-profiles-daemon.enable = true; # Allows the user to change system behavior by changing power profiles

      # For optimizing laptop battery life
      tlp = {
        enable = true;
        settings = {
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
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
