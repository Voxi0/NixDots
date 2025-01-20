_: {
  # Import Nix modules
  imports = [
    # Essential settings and plugins e.g. file explorer
    ./settings.nix ./ui.nix ./language.nix ./nvimtree.nix
  ];
}
