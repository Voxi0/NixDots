{ pkgs, lib, config, ... }: {
  # Import Nix modules
  imports = [
    ./zsh.nix ./kitty.nix ./firefox.nix ./git.nix ./vscode.nix ./vesktop.nix
  ];

  # Enable all applications by default
  zsh.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;
  vesktop.enable = lib.mkDefault true;
}
