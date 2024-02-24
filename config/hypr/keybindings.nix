{ config, pkgs, ... }:

let
  scriptsParams = {
    inherit config;
    inherit pkgs;
  };
  bg-selector = import ./scripts/bg-selector.nix scriptsParams;
  bg-cycle = import ./scripts/bg-cycle.nix scriptsParams;
  hypr-screenshot = import ./scripts/hypr-screenshot.nix scriptsParams;
  theme-selector = import ./scripts/theme-selector.nix scriptsParams;
in
{
  wayland.windowManager.hyprland.settings = {
	"$mod" = "SUPER";
	"$left" = "H";
	"$right" = "L";
	"$up" = "K";
	"$down" = "J";
	bind =
	  [
    "$mod, Q, killactive"
		"$mod, C, exit"
		"$mod SHIFT, Space, togglefloating"
		"$mod, G, centerwindow"
		"$mod, D, exec, wofi -c ${config.xdg.configHome}/wofi/config -I"
    "$mod, F1, exec, nwg-bar"

    # Special workspace
    "$mod SHIFT, minus, movetoworkspace, special"
    "$mod, minus, togglespecialworkspace"

		# Move focus with mod + HJKL
		"$mod, $left, hy3:movefocus, l"
		"$mod, $right, hy3:movefocus, r"
		"$mod, $up, hy3:movefocus, u"
		"$mod, $down, hy3:movefocus, d"

		# Move windows with mod + HJKL
		"$mod SHIFT, $left, hy3:movewindow, l"
		"$mod SHIFT, $right, hy3:movewindow, r"
		"$mod SHIFT, $up, hy3:movewindow, u"
		"$mod SHIFT, $down, hy3:movewindow, d"

		# Groups tabbed
		"$mod, B, hy3:makegroup, h"
		"$mod, V, hy3:makegroup, v"
		"$mod, W, hy3:changegroup, tab"
		"$mod, E, hy3:changegroup, untab"
		"$mod, S, hy3:changegroup, opposite"
		"$mod, A, hy3:changefocus, raise"
		"$mod, I, hy3:changefocus, lower"
		"$mod, left, changegroupactive, b"
		"$mod, right, changegroupactive, f"

		# Layout stuff
		"$mod, F, fullscreen"
		"$mod, Tab, bringactivetotop"

        # Scroll through existing workspaces with mainMod + scroll
		"$mod, mouse_down, workspace, e+1"
		"$mod, mouse_up, workspace, e-1"

		# App shortcuts
		"$mod, O, exec, vivaldi"
		"$mod, N, exec, nautilus"
		"$mod, Return, exec, alacritty"

		# Screenshots
		", PRINT, exec, grimshot --notify save screen"
		"SHIFT, PRINT, exec, ${hypr-screenshot}/bin/hypr-screenshot"

        # Color picker (requires hyprpicker and wl-clipboard)
		"$mod, Z, exec, hyprpicker -a"

		# Theme switcher
		"$mod, T, exec, ${theme-selector}/bin/theme-selector"

		# Background
		"$mod, U, exec, ${bg-selector}/bin/bg-selector" # Apps background
        "$mod, Y, exec, ${bg-cycle}/bin/bg-cycle" # Bg cycle

        # Hycov
        "ALT, $left, hycov:movefocus, l"
        "ALT, $right, hycov:movefocus, r"
        "ALT, $up, hycov:movefocus, u"
        "ALT, $down, hycov:movefocus, d"
        "$mod, tab, hycov:toggleoverview"
	  ]
	  ++ (
		# workspaces
		# binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
		builtins.concatLists (builtins.genList (
			x: let
			  ws = let
				c = (x + 1) / 10;
			  in
				builtins.toString (x + 1 - (c * 10));
			in [
			  "$mod, ${ws}, workspace, ${toString (x + 1)}"
			  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
			]
		  )
		  10)
	  );
  };
  wayland.windowManager.hyprland.extraConfig = ''
  # Resize window
  bind = $mod, R, submap, resize
  
  submap=resize
  
  binde = ,$left, resizeactive, -10 0
  binde = ,$right, resizeactive, 10 0
  binde = ,$up, resizeactive, 0 -10
  binde = ,$down, resizeactive, 0 10
  
  binde = ,left, resizeactive, -100 0
  binde = ,right, resizeactive, 100 0
  binde = ,up, resizeactive, 0 -100
  binde = ,down, resizeactive, 0 100
  
  bind = ,escape, submap, reset
  bind = ,Return, submap, reset
  
  submap = reset

  # Move window
  bind = $mod, M, submap, move

  submap = move
  
  bind = ,$left, moveactive, -10 0
  bind = ,$right, moveactive, 10 0
  bind = ,$up, moveactive, 0 -10
  bind = ,$down, moveactive, 0 10
  
  bind = ,left, moveactive, -100 0
  bind = ,right, moveactive, 100 0
  bind = ,up, moveactive, 0 -100
  bind = ,down, moveactive, 0 100
  
  bind = ,escape, submap, reset
  bind = ,Return, submap, reset
  
  submap = reset

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mod, mouse:272, movewindow
  bindm = $mod, mouse:273, resizewindow
  '';

}
