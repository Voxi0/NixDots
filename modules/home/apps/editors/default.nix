_: {
  # Import Nix modules
  imports = [
    ./neovim.nix ./zed.nix ./vscode.nix ./emacs.nix
  ];

  # Enable all editors by default
  enableNeovim = lib.mkDefault true;
  enableZed = lib.mkDefault true;
  enableVSCode = lib.mkDefault true;
  enableEmacs = lib.mkDefault true;
}
