{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    go-sct
  ];
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waysct -mode timed -dayTemp 7000"
    ];
  };
}
