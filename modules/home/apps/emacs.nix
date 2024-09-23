{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    emacs.enable = lib.mkEnableOption true;
  };

  # Configure Emacs if it's enabled
  config = lib.mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = with pkgs.emacsPackages [];
      extraConfig = '''';
    };
  }
}