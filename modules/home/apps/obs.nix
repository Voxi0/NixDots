{
  lib,
  config,
  pkgs,
  ...
}: {
  # Module options
  options.apps.enableOBS = lib.mkEnableOption "Enable OBS - For screen recording and such";

  # Configuration
  config = lib.mkIf config.apps.enableOBS {
    # For screen recording and such
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs # Lets you capture from Wlroots based Wayland compositors
        obs-pipewire-audio-capture # Pipewire audio capturing
        obs-vaapi # GStreamer based VAAPI encoder implementation - Supports H.264, H.265 and AV1
        obs-vkcapture # For Vulkan/OpenGL game capture on Linux
      ];
    };
  };
}
