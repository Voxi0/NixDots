{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    neovim.enable = lib.mkEnableOption "Enables Neovim";
  };

  # Configure Neovim if it's enabled
  config = lib.mkIf config.neovim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}