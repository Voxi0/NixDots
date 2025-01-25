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
          -- Lazygit
          {
            "kdheepak/lazygit.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            lazy = true,
            cmd = {
              "LazyGit",
              "LazyGitConfig",
              "LazyGitCurrentFile",
              "LazyGitFilter",
              "LazyGitFilterCurrentFile",
            },
            keys = {
              { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
            },
          },
        }
      '';
      extraConfig = ''
      '';
    };
  };
}
