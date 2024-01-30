{ config, pkgs, ... }:

{
  imports = [
    ./clipboard.nix
    ./input.nix
    ./keybindings.nix
    ./misc.nix
    ./mount.nix
    ./night-light.nix
    ./notification.nix
    ./xwayland.nix
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
