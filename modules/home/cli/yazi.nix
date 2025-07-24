{
  lib,
  config,
  ...
}: {
  # Module options
  options.cli.enableYazi = lib.mkEnableOption "Enable Yazi - A modern and fancy TUI file manager with file previews and such";

  # Fancy and modern TUI file manager written in Rust with previews and such
  config = lib.mkIf config.cli.enableYazi {
    programs.yazi = {
      enable = true;
      settings = {
        input.cursor_blink = false;
        mgr = {
          ratio = [1 2 3]; # Parent, current and preview windows width
          show_hidden = false;
          show_symlink = false;
          sort_by = "natural";
          sort_reverse = false;
          sort_sensitive = true;
          linemode = "size";
        };
        preview = {
          wrap = "no";
          image_filter = "nearest";
          image_quality = 50;
        };
      };
    };
  };
}
