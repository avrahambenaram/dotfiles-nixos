{ config, pkgs, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
in 
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];
  wayland.windowManager.sway.config = {
    startup = [{
      command = "swaync";
    }];
    keybindings = {
      "${modifier}+p" = "exec swaync-client -t -sw";
    };
  };
}
