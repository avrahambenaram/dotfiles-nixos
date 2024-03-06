{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    go-sct
  ];
  wayland.windowManager.sway.config.startup = [{
    command = "waysct -mode timed";
  }];
}
