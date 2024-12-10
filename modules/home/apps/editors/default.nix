{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./neovim.nix ./vscode.nix ./emacs.nix
  ];

  # Enable all editors by default
  enableNeovim = lib.mkDefault true;
  enableVSCode = lib.mkDefault true;
  enableEmacs = lib.mkDefault true;
}
