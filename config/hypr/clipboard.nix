{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cliphist
    wl-clipboard
    wl-clip-persist
  ];
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "wl-paste --type text --watch cliphist store" #Stores only text data
      "wl-paste --type image --watch cliphist store" #Stores only image data
      "wl-clip-persist -c regular" # Persists copy even after closing origin app
    ];
    bind = [
      "$mod, X, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
    ];
  };
}
