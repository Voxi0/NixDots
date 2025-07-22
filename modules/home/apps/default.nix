{
  lib,
  config,
  ...
}: {
  # Import Nix modules
  imports = [
    ./browser # Browser
    ./spotify.nix # Using Spicetify
    ./kitty.nix # Terminal emulator
    ./discord.nix # Discord + Vencord
    ./obs.nix # For screen recording and such
  ];
}
