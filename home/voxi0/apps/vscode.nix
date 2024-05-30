{ config, pkgs, ... }: {
  # VSCode Config
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ritwickdey.liveserver
    ];
  };
}
