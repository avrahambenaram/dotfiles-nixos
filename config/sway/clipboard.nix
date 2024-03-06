{ config, pkgs, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
in 
{
  home.packages = with pkgs; [
    cliphist
    wl-clipboard
    wl-clip-persist
  ];
  wayland.windowManager.sway.config = {
    startup = [
      {
        command = "wl-paste --type text --watch cliphist store";
      }
      {
        command = "wl-paste --type image --watch cliphist store";
      }
      {
        command = "wl-clip-persist -c regular";
      }
    ];
    keybindings = {
      "${modifier}+x" = "exec cliphist list | wofi --dmenu | cliphist decode | wl-copy";
    };
  };
}
