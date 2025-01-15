{ lib, ... }: {
  # Import Nix modules
  imports = [
    ./shell.nix ./editors ./git.nix ./nixcord.nix ./browser ./obsidian.nix ./music.nix
  ];

  # Enable all applications by default
  enableGit = lib.mkDefault true;
  enableFirefox = lib.mkDefault true;
  enableNixcord = lib.mkDefault true;
	enableObsidian = lib.mkDefault true;
	enableSpotify = lib.mkDefault true;
  enableNcmpcpp = lib.mkDefault true;
}
