{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./shell.nix ./editors ./firefox.nix ./git.nix ./nixcord.nix
  ];

  # Enable all applications by default
  enableZSH = lib.mkDefault true;
  enableKitty = lib.mkDefault true;
  enableFirefox = lib.mkDefault true;
  enableGit = lib.mkDefault true;
  enableNixcord = lib.mkDefault true;
}
