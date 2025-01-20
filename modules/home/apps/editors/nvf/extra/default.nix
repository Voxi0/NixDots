_: {
  # Import Nix modules
  imports = [
    # Super useful plugins e.g. fuzzy file finder
    ./neocord.nix ./telescope.nix ./extraplugins.nix ./utilities.nix
  ];
}
