{pkgs, ...}: {
  # Useful programs
  programs = {
    nh.enable = true; # Nix Helper CLI (NH)
    nix-your-shell.enable = true; # Use preferred shell instead of Bash in Nix shells
    zoxide.enable = true; # Smarter `cd` command
  };

  # Packages
  home.packages = with pkgs; [btop];
}
