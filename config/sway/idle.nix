{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swayidle
  ];
  wayland.windowManager.sway.config.startup = [
    {
      command = "${pkgs.swayidle}/bin/swayidle -w timeout 80 'swaymsg \"output * power off\"' resume 'swaymsg \"output * power on\"'";
    }
  ];
}
