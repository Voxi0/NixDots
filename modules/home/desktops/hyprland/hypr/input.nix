{kbLayout, ...}: {
  #############
  ### INPUT ###
  #############
  wayland.windowManager.hyprland.settings = {
    input = {
      # Keyboard
      kb_layout = kbLayout;
      # kb_variant =
      # kb_model =
      # kb_options =
      # kb_rules =
      numlock_by_default = true;
      follow_mouse = 1;

      # Mouse acceleration
      sensitivity = 0;

      # Touchpad
      touchpad.natural_scroll = false;
    };

    # Touchpad gestures
    gestures.workspace_swipe_forever = true;
  };
}
