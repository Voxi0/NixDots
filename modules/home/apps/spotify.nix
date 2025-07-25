{
  lib,
  config,
  system,
  inputs,
  ...
}: {
  # Import Nix modules
  imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

  # Module options
  options.apps.enableSpotify = lib.mkEnableOption "Enable Spotify (Spicetify)";

  # Configuration
  config = lib.mkIf config.apps.enableSpotify {
    # Powerful CLI tool to take control of the Spotify client
    programs.spicetify = {
      enable = true;
      wayland = true;
      enabledExtensions = with inputs.spicetify-nix.legacyPackages.${system}.extensions; [
        adblock # Remove ads
        lastfm # Integrate with LastFM to show listening stats for a song and get it's LastFM link
        autoSkipVideo # Video playback e.g. ads causes issues in some regions where videos can't be played so skip them
        groupSession # Allows you to create a link to share with your friends to listen along with you
      ];
    };
  };
}
