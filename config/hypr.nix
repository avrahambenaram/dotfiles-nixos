{ config, pkgs, ... }:

{
  imports = [
    ./hypr/clipboard.nix
    ./hypr/input.nix
    ./hypr/keybindings.nix
    ./hypr/misc.nix
    ./hypr/mount.nix
    ./hypr/night-light.nix
    ./hypr/notification.nix
    ./hypr/xwayland.nix
  ];
  wayland.windowManager.hyprland.settings = {
    source = [
      "${config.xdg.configHome}/hypr/theme.conf"
      "${config.xdg.configHome}/hypr/monitors.conf"
    ];
    "exec-once" = [
      "touch ${config.xdg.configHome}/hypr/monitors.conf"
    ];
  };
}
