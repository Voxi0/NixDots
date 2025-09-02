{inputs, ...}: {
  # Import Nix modules
  imports = [inputs.vicinae.homeManagerModules.default];

  services.vicinae = {
    enable = true;
    autoStart = true;
  };
}
