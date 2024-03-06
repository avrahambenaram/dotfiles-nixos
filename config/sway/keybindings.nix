{ config, pkgs, ... }:

let
  modifier = "Mod4";
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
  wayland.windowManager.sway.config = {
    modifier = modifier;
    keybindings = {
      # Basics
      "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      "${modifier}+F1" = "exec nwg-bar";
      "${modifier}+q" = "kill";
      "${modifier}+d" = "exec wofi -c ${config.xdg.configHome}/wofi/config -I";
      "${modifier}+c" = "exit";
      "${modifier}+z" = "exec hyprpicker -a";

      # Moving around
      "${modifier}+h" = "focus left";
      "${modifier}+j" = "focus down";
      "${modifier}+k" = "focus up";
      "${modifier}+l" = "focus right";
      "${modifier}+Left" = "focus left";
      "${modifier}+Down" = "focus down";
      "${modifier}+Up" = "focus up";
      "${modifier}+Right" = "focus right";

      "${modifier}+Shift+h" = "move left";
      "${modifier}+Shift+j" = "move down";
      "${modifier}+Shift+k" = "move up";
      "${modifier}+Shift+l" = "move right";
      "${modifier}+Shift+Left" = "move left";
      "${modifier}+Shift+Down" = "move down";
      "${modifier}+Shift+Up" = "move up";
      "${modifier}+Shift+Right" = "move right";

      # Workspaces
      "${modifier}+1" = "workspace number 1";
      "${modifier}+2" = "workspace number 2";
      "${modifier}+3" = "workspace number 3";
      "${modifier}+4" = "workspace number 4";
      "${modifier}+5" = "workspace number 5";
      "${modifier}+6" = "workspace number 6";
      "${modifier}+7" = "workspace number 7";
      "${modifier}+8" = "workspace number 8";
      "${modifier}+9" = "workspace number 9";
      "${modifier}+0" = "workspace number 0";

      "${modifier}+Shift+1" = "move container to workspace number 1";
      "${modifier}+Shift+2" = "move container to workspace number 2";
      "${modifier}+Shift+3" = "move container to workspace number 3";
      "${modifier}+Shift+4" = "move container to workspace number 4";
      "${modifier}+Shift+5" = "move container to workspace number 5";
      "${modifier}+Shift+6" = "move container to workspace number 6";
      "${modifier}+Shift+7" = "move container to workspace number 7";
      "${modifier}+Shift+8" = "move container to workspace number 8";
      "${modifier}+Shift+9" = "move container to workspace number 9";
      "${modifier}+Shift+0" = "move container to workspace number 0";

      # Layout stuff:
      "${modifier}+b" = "splith";
      "${modifier}+v" = "splitv";

      "${modifier}+s" = "layout stacking";
      "${modifier}+w" = "layout tabbed";
      "${modifier}+e" = "layout toggle split";

      "${modifier}+f" = "fullscreen";

      "${modifier}+Shift+space" = "floating toggle";

      "${modifier}+space" = "focus mode_toggle";

      "${modifier}+a" = "focus parent";


      # Scratchpad:
      "${modifier}+Shift+minus" = "move scratchpad";
      "${modifier}+minus" = "scratchpad show";

      # Modes
      "${modifier}+r" = "mode \"resize\"";
      "${modifier}+m" = "mode \"move\"";

      # App shortcuts
      "${modifier}+o" = "exec firefox";
      "${modifier}+n" = "exec thunar";

      # Screenshots
      "print" = "exec grimshot --notify save screen";
      "Shift+print" = "exec ${wm-screenshot}/bin/wm-screenshot";

      # Theme switcher
      "${modifier}+t" = "exec ${theme-selector}/bin/theme-selector";

      # Background
      "${modifier}+u" = "exec ${bg-selector}/bin/bg-selector";
      "${modifier}+y" = "exec ${bg-cycle}/bin/bg-cycle";
    };
    modes = {
      resize = {
        Escape = "mode default";
        Return = "mode default";
        Down = "resize grow height 100 px";
        Left = "resize shrink width 100 px";
        Right = "resize grow width 100 px";
        Up = "resize shrink height 100 px";
        h = "resize shrink width 10 px";
        j = "resize grow height 10 px";
        k = "resize shrink height 10 px";
        l = "resize grow width 10 px";
      };
      move = {
        Escape = "mode default";
        Return = "mode default";
        Down = "move down 100 px";
        Left = "move left 100 px";
        Right = "move right 100 px";
        Up = "move up 100 px";
        h = "move left 10 px";
        j = "move down 10 px";
        k = "move up 10 px";
        l = "move right 10 px";
      };
    };
  };
}
