{ config, pkgs, ... }:

let
  fader = import ../scripts/fader.nix { inherit pkgs; };
in 
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
      {
        command = "${fader}/bin/fader";
      }
    ];
  };
  wayland.windowManager.sway.swaynag.enable = true;
}
