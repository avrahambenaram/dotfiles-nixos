{ config, pkgs, ... }:

{
  wayland.windowManager.sway.config = {
    input = {
      "*" = {
        xkb_layout = "br";
        xkb_variant = "abnt2";
      };
    };
    keybindings = {
      "Shift_R" = "exec ${pkgs.wtype}/bin/wtype '/'";
      "Shift+Shift_R" = "exec ${pkgs.wtype}/bin/wtype '?'";
    };
  };
}
