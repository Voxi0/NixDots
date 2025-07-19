{
  lib,
  config,
  pkgs,
  ...
}: {
  # A window switcher, application launcher and dmenu replacement
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [rofi-emoji];
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.kitty}/bin/kitty";
    modes = ["drun" "emoji"];
    location = "center";
    extraConfig = {
      # Drun app entry config
      show-icons = true;
      drun-display-format = "{icon} {name}";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      # Remove all margin, padding and spacing
      "*" = {
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      # Window
      "window" = {
        width = mkLiteral "20%";
        border-radius = mkLiteral "6px";
      };

      # Search bar
      "inputbar" = {
        children = map mkLiteral ["icon-search" "entry"];
        spacing = mkLiteral "8px";
        padding = mkLiteral "4px 8px";
      };
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

      # Container that holds all the entries
      "listview" = {
        lines = 4;
        columns = 1;
        scrollbar = false;
        fixed-height = true;
        spacing = mkLiteral "0px";
        padding = mkLiteral "0px";
      };

      # Menu entries
      "element" = {
        orientation = mkLiteral "horizontal";
        children = map mkLiteral ["element-icon" "element-text"];
        margin = mkLiteral "0px 4px";
        padding = mkLiteral "4px";
        border-radius = mkLiteral "6px";
      };
      "element-icon" = {
        cursor = mkLiteral "pointer";
        size = mkLiteral "32px";
        vertical-align = mkLiteral "0.5";
        padding = mkLiteral "0px";
      };
      "element-text" = {
        cursor = mkLiteral "pointer";
        vertical-align = mkLiteral "0.5";
        padding = mkLiteral "0px";
      };
    };
  };
}
