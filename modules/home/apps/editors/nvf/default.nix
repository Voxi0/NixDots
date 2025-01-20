{ lib, config, inputs, ... }: {
  # Import Nix modules
  imports = [
    inputs.nvf.homeManagerModules.default
    ./core    # Essential settings and plugins
    ./extra   # Super useful plugins
  ];

  # Module options
  options.enableNeovim = lib.mkEnableOption "Enables Neovim"; 

  # Configure Neovim if it's enabled - Just enable NVF, configuration is in the other files
  config = lib.mkIf config.enableNeovim {
    programs.nvf.enable = true;
  };
}
