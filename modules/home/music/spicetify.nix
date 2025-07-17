{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  # Import Nix modules
  imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

  # Module options
  options.enableSpotify = lib.mkEnableOption "Enable Spotify (Spicetify)";

  # Configuration
  config = lib.mkIf config.enableSpotify {
    # Spicetify - Powerful CLI tool to take control of the Spotify client
    programs.spicetify = {
      enable = true;
      wayland = true;
      enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
        adblock # Remove ads
        lastfm # Integrate with LastFM to show listening stats for a song and get it's LastFM link
        autoSkipVideo # Video playback e.g. ads causes issues in some regions where videos can't be played so skip them
        powerBar # Spotlight-like search bar
        groupSession # Allows you to create a link to share with your friends to listen along with you
        simpleBeautifulLyrics # Simple theme for lyrics
      ];
    };
  };
}
