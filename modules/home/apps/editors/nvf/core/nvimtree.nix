_: {
  # File explorer
  programs.nvf.settings.vim.filetree.nvimTree = {
    enable = true;
    openOnSetup = false;
    mappings.toggle = "<C-n>";            # Toggle file explorer with Control + N
    setupOpts = {
      # Disable the default Neovim file explorer
      disable_netrw = true;

      # Indicate which files have unsaved modifications
      modified = {
        enable = true;
        show_on_dirs = true;              # Show modified icons on parent directories
      };

      # Close file explorer upon opening a file and any window displaying a file when removing the file from the tree
      actions = {
        change_dir.enable = true;
        change_dir.global = false;
        use_system_clipboard = true;      # Use the system clipboard when copy/paste functions are invoked
        open_file.quit_on_open = true;    # Close file explorer upon opening a file
        remove_file.close_window = true;  # Close any window displaying a file when it's removed from the file tree
      };

      # Show LSP and COC diagnostics in the signcolumn - Modified sign takes precedence over this
      diagnostics = {
        enable = true;
        show_on_dirs = true;
      };

      # Filter files in the file explorer
      filters = {
        dotfiles = false;                 # Show files starting with a fullstop
        git_ignored = true;               # Ignore files based on '.gitignore'
        exclude = [ ];
      };

      # Git integration
      git = {
        enable = true;
        show_on_dirs = true;              # Show Git icons on parent directories
      };
    };
  };
}
