{inputs, ...}: {
  # Import Nix modules
  imports = [inputs.xremap.homeManagerModules.default];

  # Configuration
  services.xremap = {
    config.modmap = [
      {
        name = "Global";
        remap = {"CapsLock" = "Esc";};
      }
    ];
  };
}
