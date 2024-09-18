{ pkgs, ... }: {
  # Networking
  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Network manager applet
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
