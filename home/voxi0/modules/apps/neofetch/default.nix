{ config, pkgs, ... }: {
  # Dotfiles/Images
  home.file.".config/neofetch/config.conf".source = ./config.conf;
  home.file.".config/neofetch/image.svg".source = ./image.svg;
}
