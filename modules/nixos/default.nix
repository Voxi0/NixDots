_: {
  # Import Nix modules
  imports = [
    ./hardware.nix ./lanzaboote.nix ./services.nix
		./stylix.nix ./programs.nix ./fish.nix ./desktops ./gaming.nix
  ];
}
