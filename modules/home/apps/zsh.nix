{ pkgs, lib, config, ... }: {
  # Module options
  options = {
    zsh.enable = lib.mkEnableOption "Enables ZSH";
  };

  # Configure ZSH if it's enabled
  config = lib.mkIf config.zsh.enable {
    # Install ZSH packages
    home.packages = with pkgs; [
      oh-my-zsh thefuck fzf
    ];

    # ZSH configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Shell aliases to make it faster to type frequently used commands
      shellAliases = {
        ll = "ls -l";
        la = "ls -a";
        update = "sudo nixos-rebuild switch";
        clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      };

      # Command history
      history.size = 1000;

      # Oh-My-ZSH
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" "fzf" ];
        theme = "lambda";
      };
    };
  };
}
