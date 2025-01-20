_: {
  settings.vim = {
    # Open Neovim whenever "vi" or "vim" command is executed
    viAlias = true;
    vimAlias = true;

    # Follow editorconfig rules in current directory
    globals.editorconfig = true;

    # Enable experimental Lua module loader to speed up the start process
    enableLuaLoader = true;

    # General
    globals.mapleader = " ";
    lineNumberMode = "relative";
    spellcheck.enable = true;
    preventJunkFiles = true;                # Prevent swapfile and backupfile from being created
    useSystemClipboard = true;              # Required to copy text from Neovim and paste it somewhere else and vice versa
    disableArrows = false;                  # Prevent arrow keys from moving the cursor

    # Options
    options = {
      termguicolors = true;
      updatetime = 100;											# Make Neovim slightly faster
      wrap = false;													# Don't let any text wrap around the screen
    };

    # Lua
    options = {
      # Indentation
      "shiftwidth" = 2;
      "tabstop" = 2;
      "softtabstop" = 2;
      "smartindent" = false;
      "expandtab" = true;										# Use spaces for indentation

      # Code folding
      "foldmethod" = "expr";
      "foldexpr" = "nvim_ufo#foldexpr()";
      "foldcolumn" = "0";
      "foldlevel" = 99;
      "foldlevelstart" = 99;
      "foldenable" = true;

      # File encoding
      "encoding" = "utf-8";
      "fileencoding" = "utf-8";
    };

    # Theme
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };
  };
}
