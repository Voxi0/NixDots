{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  # Module options
  options = {
    enableNeovim = lib.mkEnableOption "Enables Neovim"; 
  };

  # Configure Neovim if it's enabled
  config = lib.mkIf config.enableNeovim {
    programs.nvf = {
      enable = true;
      settings.vim = {
        # Open Neovim whenever "vi" or "vim" command is executed
        viAlias = true;
        vimAlias = true;

        # Follow editorconfig rules in current directory
        enableEditorconfig = true;

        # Dashboard
        dashboard.alpha.enable = true;

        # Autoindent, autocomplete, automatically pair characters e.g. "()"
        autoIndent = true;
        autocomplete= {
          enable = true;
          alwaysComplete = true;
        };
        autopairs.enable = true;

        # WhichKey to show keybinds
        binds.whichKey.enable = true;

        # Powerful comment plugin
        comments.comment-nvim.enable = true;

        # Debugging
        debugger = {
          nvim-dap = {
            enable = true;
            ui = {
              enable = true;
              autoStart = true;
            };
          };
        };
      };
    };
  };
}
