{
  wayland.windowManager.hyprland.settings = {
    xwayland = {
	  force_zero_scaling = true;
	};
	windowrulev2 = [
	  "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
	  "noanim,class:^(xwaylandvideobridge)$"
	  "nofocus,class:^(xwaylandvideobridge)$"
	  "noinitialfocus,class:^(xwaylandvideobridge)$"
	];
  };
  wayland.windowManager.hyprland.extraConfig = ''
  xwayland enabled
  '';
}
