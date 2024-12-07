{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./shell.nix ./editors ./git.nix ./nixcord.nix ./browsers ./obsidian.nix
  ];

  # Enable all applications by default
  enableZSH = lib.mkDefault true;
  enableKitty = lib.mkDefault true;
  enableGit = lib.mkDefault true;
  enableNixcord = lib.mkDefault true;
	enableObsidian = lib.mkDefault true;
}
