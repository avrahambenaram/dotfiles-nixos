{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    udiskie
  ];
  wayland.windowManager.sway.config.startup = [{
    command = "udiskie -s -n -a &";
  }];
}
