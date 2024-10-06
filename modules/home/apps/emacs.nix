{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableEmacs = lib.mkEnableOption "Enables Emacs";
  };

  # Configure Emacs if it's enabled
  config = lib.mkIf config.enableEmacs {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs: with epkgs; [
        magit
      ];
      extraConfig = '''';
    };
  };
}
