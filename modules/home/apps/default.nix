{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./shell.nix ./editors ./git.nix ./nixcord.nix ./floorp ./obsidian.nix ./spotify.nix
  ];

  # Enable all applications by default
  enableGit = lib.mkDefault true;
  enableFloorp = lib.mkDefault true;
  enableNixcord = lib.mkDefault true;
	enableObsidian = lib.mkDefault true;
	enableSpotify = lib.mkDefault true;
}
