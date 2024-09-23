{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    emacs.enable = lib.mkEnableOption "Enables Emacs";
  };

  # Configure Emacs if it's enabled
  config = lib.mkIf config.emacs.enable {
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
