{ config, pkgs, ... }:

{
  wayland.windowManager.sway.config = {
    defaultWorkspace = "workspace number 1";
    bars = [];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    window = {
      titlebar = false;
    };
    startup = [
      {
        command = "touch /home/avraham/.config/sway/outputs";
      }
      {
        command = "swww init";
      }
    ];
  };
  wayland.windowManager.sway.swaynag.enable = true;
}
