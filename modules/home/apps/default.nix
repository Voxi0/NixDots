{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./shell.nix ./neovim.nix ./emacs.nix ./firefox.nix ./git.nix ./vscode.nix ./vesktop.nix
  ];

  # Enable all applications by default
  enableZSH = lib.mkDefault true;
  enableKitty = lib.mkDefault true;
  enableNeovim = lib.mkDefault true;
  enableEmacs = lib.mkDefault true;
  enableVSCode = lib.mkDefault true;
  enableFirefox = lib.mkDefault true;
  enableGit = lib.mkDefault true;
  enableVesktop = lib.mkDefault true;
}
