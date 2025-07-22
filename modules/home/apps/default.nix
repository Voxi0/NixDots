_: {
  # Import Nix modules
  imports = [
    ./browser # Browser
    ./music # Music stuff e.g. NCMPCPP and Spotify
    ./kitty.nix # Terminal emulator
    ./discord.nix # Discord + Vencord
  ];
}
