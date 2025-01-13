{ lib, config, ... }: {
  # Module options
  options.enableEmacs = lib.mkEnableOption "Enables Emacs";

  # Configure Emacs if it's enabled
  config = lib.mkIf config.enableEmacs {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: with epkgs; [ magit ];
      extraConfig = ''
        (setq standard-indent 2)
      '';
    };
  };
}
