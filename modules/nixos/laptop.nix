{
  lib,
  config,
  ...
}: {
  # Module options
  options.enableLaptopSupport = lib.mkEnableOption "Enable laptop support e.g. battery optimizations";

  # Configuration
  config = lib.mkIf config.enableLaptopSupport {
    # Tool provided by Intel to run diagnostics and analyze power consumption to give suggestions
    # Apply said suggestions with TLP and auto-cpufreq, use powertop only for analyzing
    powerManagement.powertop.enable = true;

    services = {
      # Daemon that monitors and controls temperature to prevent overheating
      thermald.enable = true;

      # Forcefully disable this because it interferes with TLP and isn't required here
      power-profiles-daemon.enable = lib.mkForce false;

      # For optimizing laptop battery life
      tlp.enable = true;

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
  };
}
