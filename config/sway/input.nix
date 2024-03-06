{
  wayland.windowManager.sway.config = {
    input = {
      "*" = {
        xkb_layout = "br";
        xkb_variant = "abnt2";
      };
    };
    keybindings = {
      "Control+Alt+q" = "exec wtype '/'";
      "Control+Alt+w" = "exec wtype '?'";
      "Control+Alt+e" = "exec wtype '°'";
    };
  };
}
