{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableVSCode = lib.mkEnableOption "Enables VSCode";
  };

  # Configure VSCode if it's enabled
  config = lib.mkIf config.enableVSCode {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # Nice to have
        esbenp.prettier-vscode
        streetsidesoftware.code-spell-checker
        jgclark.vscode-todo-highlight

        # Nix
        jnoortheen.nix-ide
        jeff-hykin.better-nix-syntax
      ];
    };
  };
}
