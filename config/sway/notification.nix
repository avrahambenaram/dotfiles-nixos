{ config, pkgs, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
in 
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];
  wayland.windowManager.sway.config = {
    keybindings = {
      "${modifier}+p" = "exec swaync-client --reload-css && swaync-client -t -sw";
    };
  };
}
