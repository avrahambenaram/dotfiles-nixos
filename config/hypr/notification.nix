{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
	  "swaync"
	];
	bind = [
	  "$mod, P, exec, swaync-client -t -sw"
	];
  };
}
