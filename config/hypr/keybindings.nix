{ config, pkgs, ... }:

let
  generateDirectionKeys = import ./utils/generateDirectionKeys.nix;
  scriptsParams = {
    inherit config;
    inherit pkgs;
  };
  bg-selector = import ../scripts/bg-selector.nix scriptsParams;
  bg-cycle = import ../scripts/bg-cycle.nix scriptsParams;
  wm-screenshot = import ../scripts/wm-screenshot.nix scriptsParams;
  theme-selector = import ../scripts/theme-selector.nix scriptsParams;
in
{
  home.packages = with pkgs; [
    # Screenshot
    grim
    grimblast
    sway-contrib.grimshot
    slurp

    # Color picker
    nur.repos.avrahambenaram.hyprpicker
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
	"$mod" = "SUPER";
	"$left" = "H";
	"$right" = "L";
	"$up" = "K";
	"$down" = "J";
	bind =
    # Move focus with mod + HJKL
    (generateDirectionKeys (key: direction: "$mod, ${key}, hy3:movefocus, ${direction}"))
    ++

    # Move windows with mod + HJKL
    (generateDirectionKeys (key: direction: "$mod SHIFT, ${key}, hy3:movewindow, ${direction}"))
    ++
	  [
    "$mod, Q, hy3:killactive"
		"$mod, C, exit"
		"$mod, Space, cyclenext"
		"$mod SHIFT, Space, togglefloating"
		"$mod, G, centerwindow"
		"$mod, D, exec, wofi -c ${config.xdg.configHome}/wofi/config -I"
    "$mod, F1, exec, nwg-bar"

    # Special workspace
    "$mod SHIFT, minus, movetoworkspace, special"
    "$mod, minus, togglespecialworkspace"

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
		"$mod, O, exec, firefox"
		"$mod, N, exec, nautilus"
		"$mod, Return, exec, alacritty"

		# Screenshots
		", PRINT, exec, grimshot --notify save screen"
		"SHIFT, PRINT, exec, ${wm-screenshot}/bin/wm-screenshot"

    # Color picker (requires hyprpicker and wl-clipboard)
		"$mod, Z, exec, hyprpicker -a"

		# Theme switcher
		"$mod, T, exec, ${theme-selector}/bin/theme-selector"

		# Background
		"$mod, U, exec, ${bg-selector}/bin/bg-selector" # Apps background
    "$mod, Y, exec, ${bg-cycle}/bin/bg-cycle" # Bg cycle
	  ]
	  ++ (
		# workspaces
		# binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
		builtins.concatLists (builtins.genList (
      x:
        let
          ws =
            let
              c = (x + 1) / 10;
            in
            builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, hy3:movetoworkspace, ${toString (x + 1)}, follow"
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
