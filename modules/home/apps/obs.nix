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
        wlrobs # Capture from Wlroots based Wayland compositors
        obs-pipewire-audio-capture
        obs-vaapi # VAAPI encoder implementation for H.264, H.265 and AV1

        # AMD hardware acceleration
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };
}
