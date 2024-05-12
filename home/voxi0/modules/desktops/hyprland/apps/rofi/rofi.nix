{ config, pkgs, ... }: {
  # Rofi Configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font 11";
    location = "center";
    terminal = "kitty";
    extraConfig = {
      modes = "drun";
      display-drun = "Search:";
      drun-display-format = "{icon} {name}";
      font = "JetBrainsMono Nerd Font Regular 10";
    };
    theme = ".config/rofi/theme.rasi";
  };

  # Dotfiles
  home.file.".config/rofi/theme.rasi".source = ./theme.rasi;
}
