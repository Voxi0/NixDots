_: {
  # Import Nix modules
  imports = [
    ./useful.nix # Extra useful/handy CLI utilities
    ./fastfetch.nix # Modern system info tool designed to replace Neofetch
    ./git.nix # Git and LazyGIT (Beautiful TUI for Git that makes using Git super fast and easy)
    ./yazi.nix # Fancy and modern TUI file manager written in Rust with previews and such
    ./ncmpcpp.nix # MPD client - TUI music player
  ];
}
