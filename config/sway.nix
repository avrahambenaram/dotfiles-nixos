{ config, pkgs, ... }:

{
  imports = [
    ./sway/clipboard.nix
    ./sway/input.nix
    ./sway/keybindings.nix
    ./sway/misc.nix
    ./sway/mount.nix
    ./sway/night-light.nix
    ./sway/notification.nix
    ./sway/style.nix
  ];
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    extraConfig = ''
bar {
    swaybar_command waybar
}

for_window [shell="xdg_shell"] title_format "%title (%app_id)"
for_window [shell="x_wayland"] title_format "%class - %title"

include ~/.config/sway/theme
include ~/.config/sway/outputs
    '';
  };
}
