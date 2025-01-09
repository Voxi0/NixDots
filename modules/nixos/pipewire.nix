{ pkgs, ... }: {
  # Disable Pulseaudio to use Pipewire
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Pavucontrol to control audio devices etc.
  environment.systemPackages = with pkgs; [ pavucontrol ];
}
