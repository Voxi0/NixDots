{
  lib,
  config,
  pkgs,
  ...
}: {
  # A window switcher, application launcher and dmenu replacement
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    modes = ["drun" "run" "ssh"];
    location = "center";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      # Remove all margin, padding and spacing
      "*" = {
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      # Window
      "window" = {
        width = mkLiteral "30%";
        border-radius = mkLiteral "4px";
      };

      "textbox".padding = mkLiteral "4px 8px";

      # Change cursor type to a pointer when hovering over an entry's icon/text
      "element-icon" = {
        cursor = mkLiteral "pointer";
        size = mkLiteral "0.8em";
        vertical-align = mkLiteral "0.5";
      };
      "element-text" = {
        cursor = mkLiteral "pointer";
        vertical-align = mkLiteral "0.5";
      };

      # Search bar
      "icon-search" = {
        expand = false;
        filename = "search-symbolic";
        size = mkLiteral "14px";
        vertical-align = mkLiteral "0.5";
      };
      "entry" = {
        placeholder = "Search";
        cursor = mkLiteral "pointer";
        vertical-align = mkLiteral "0.5";
      };

      # Menu
      "element" = {
        orientation = mkLiteral "horizontal";
        children = map mkLiteral ["element-icon" "element-text"];
        padding = mkLiteral "4px 8px";
        spacing = mkLiteral "8px";
      };

      "inputbar" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "4px 8px";
        children = map mkLiteral ["icon-search" "entry"];
      };

      "listview" = {
        padding = mkLiteral "4px 0px";
        lines = 12;
        columns = 1;
        scrollbar = false;
        fixed-height = true;
        dynamic = true;
      };
    };
  };
}
