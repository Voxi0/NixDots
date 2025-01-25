{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./nvchad.nix ./vscode.nix ./emacs.nix
  ];

  # Enable all editors by default
  enableNVChad = lib.mkDefault true;
  enableVSCode = lib.mkDefault true;
  enableEmacs = lib.mkDefault true;
}
