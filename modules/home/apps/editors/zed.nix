{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableZed = lib.mkEnableOption "Enables Zed Editor";
  };

  # Configure Zed editor if it's enabled
  config = lib.mkIf config.enableZed {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      extensions = [ "Nix" "NeoCMake" "GLSL" "GDScript" "Lua" "HTML" "LiveServer" "Assembly Syntax" ];
      userSettings = {
        features.copilot = false;
        telemetry.metrics = false;
        vim_mode = true;

        # Font
        ui_font_size = 16;
        buffer_font_size = 16;
      };
    };
  };
}
