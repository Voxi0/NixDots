{ inputs, lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [ inputs.nvchad4nix.homeManagerModule ];

  # Module options
  options.enableNVChad = lib.mkEnableOption "Enables NVChad";

  # Configure NVChad if it's enabled
  config = lib.mkIf config.enableNVChad {
    programs.nvchad = {
      enable = true;
      hm-activation = true;
      backup = false;
      extraPackages = with pkgs; [];
      extraPlugins = ''
        return {
          ${builtins.readFile ./plugins/treesitter.lua}
          ${builtins.readFile ./plugins/lsp.lua}
          ${builtins.readFile ./plugins/useful.lua}
        }
      '';
      extraConfig = ''
      '';
    };
  };
}
