{ pkgs, ... }: {
  # Services
  services = {
		dbus.enable = true;     # Message bus system that allows different processes to communicate with each other
		upower.enable = true;   # Abstraction for enumerating power devices
		acpid.enable = true;    # Flexible and extensible daemon for delivering ACPI events
    libinput.enable = true; # Touchpad support
    fprintd.enable = true;  # Handles fingerprint authentications
    openssh.enable = true;  # OpenSSH daemon
    udisks2.enable = true;  # Automounts removable media
    blueman.enable = true;  # Bluetooth manager
    printing.enable = true; # CUPS to print documents

    # X11 windowing system
    xserver = {
      enable = false;
      excludePackages = [ pkgs.xterm ];

      # Keymap
      xkb = {
        layout = "gb";
	      variant = "";
      };
    };
  };
}
