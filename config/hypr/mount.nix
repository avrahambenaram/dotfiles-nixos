{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    udiskie
  ];

  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "udiskie -s -n -a &"
    ];
  };
}
