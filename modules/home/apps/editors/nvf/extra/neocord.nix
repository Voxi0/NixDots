_: {
  ###############
  ### Neocord ###
  ###############
  programs.nvf.settings.vim.presence.neocord = {
    enable = true;
    setupOpts = {
      logo = "auto";
      logo_tooltip = "The One True Text Editor";
      main_image = "language";
      show_time = true;
      auto_update = true;
      enable_line_number = false;

      # Rich presence text
      editing_text = "Editing %s";
      reading_text = "Reading %s";
      file_explorer_text = "Browsing %s";
      workspace_text = "Working on %s";
      terminal_text = "Working on The Terminal...";
      git_commit_text = "Committing Changes...";
      line_number_text = "Line %s Out of %s";
      plugin_manager_text = "Managing Plugins...";
    };
  };
}
