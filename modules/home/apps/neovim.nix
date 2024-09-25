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

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          term_colors = true;
          transparent_background = false;
          background = {
            light = "latte";
            dark = "mocha";
          };
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = true;
            nvimtree = true;
            treesitter = true;
          };
        };
      };

      # Options
      opts = {
        # Enable/Disable truecolors
        termguicolors = true;

        # Line numbering
        number = true;
        relativenumber = false;

        # Indentation
        smartindent = false;
        autoindent = false;
        shiftwidth = 4;
        tabstop = 4;
        softtabstop = 4;
        expandtab = false;

        # Faster autocompletion
        updatetime = 100;

        # Set file encoding
        encoding = "utf-8";
        fileencoding = "utf-8";
      };

      # Global options
      globals = {
        # Set leader key to space
        mapleader = " ";
      };

      # Keybinds
      keymaps = [
        {action = "<Cmd>NvimTreeToggle<CR>"; key = "<C-n>";}
      ];

      # Plugins
      plugins = {
        # Icons
        web-devicons.enable = true;

        # Dashboard
        alpha = {
          enable = true;
          theme = "dashboard";
        };

        # NvimTree - File explorer
        nvim-tree = {
          enable = true;
          disableNetrw = true;
          git.enable = true;
        };

        # Treesitter - Syntax highlighting
        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
            indent.enable = false;
          };
        };

        # LSP
        lsp = {
          enable = true;
          servers = {
            clangd.enable = true;
            ts-ls.enable = true;
            lua-ls.enable = true;
          };
        };

        # Autocompletion
        luasnip.enable = true;
        cmp_luasnip.enable = true;
        cmp-path.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {name = "nvim_lsp";}
              {name = "nvim_lua";}
              {name = "luasnip";}
              {name = "path";}
              {name = "buffer";}
            ];
            snippet.expand = ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
          };
        };

        # Noice - Experimental Neovim UI
        noice.enable = true;

        # Lualine
        lualine = {
          enable = true;
          settings.options = {
            theme = "auto";
            icons_enabled = true;
          };
        };

        # Super useful plugins
        nvim-autopairs.enable = true;
        nix.enable = true;
      };
    };
  };
}
