{ inputs, lib, pkgs, ... }: {
  # Import Nix modules
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  # For debugging and troubleshooting secure boot
  environment.systemPackages = [ pkgs.sbctl ];

  # Boot
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
