{ config, pkgs, ... }:

{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";

      # If height property would be not present, it'd be calculated dynamically
      height = 24;
      margin-left = 15;
      margin-right = 15;
      margin-top = 15;
  
      modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
      ];

      modules-center = [
          "clock"
          "hyprland/window"
          "tray"
      ];

      modules-right = [
          "network"
          "memory"
          "cpu"
          "pulseaudio"
          "battery"
          "backlight#icon"
          "backlight#value"
          "custom/power"
      ];

      # Modules

      "hyprland/window" = {
          max-length = 200;
          separate-outputs = true;
      };

      "idle_inhibitor" = {
          format = "{icon} ";
          format-icons ={
              activated = "";
              deactivated = "";
          };
      };

      battery = {
          states = {
              # good = 95;
              warning = 30;
              critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-icons = ["" "" "" "" ""];
      };

      clock = {
          interval = 10;
          format-alt = " {:%e %b %Y}"; # Icon: calendar-alt
          format = "{:%H:%M}";
          tooltip-format = "{:%e %B %Y}";
      };

      cpu = {
          interval = 5;
          format = "    {usage}% ({load})"; # Icon: microchip
          states = {
              warning = 70;
              critical = 90;
          };
          on-click = "alacritty -e 'btop'";
      };

      memory = {
          interval = 5;
          format = "   {}%"; # Icon: memory
          on-click = "alacritty -e 'btop'"; 
          states = {
              warning = 70;
              critical = 90;
          };
      };

      network = {
          interval = 5;
          format-wifi = "   ({signalStrength}%)"; # Icon: wifi
          format-ethernet = "   {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
          format-disconnected = "⚠   Disconnected";
          tooltip-format = "{essid}: {ifname} / {ipaddr}";
          on-click = "alacritty -e 'nmtui'";
      };

      "network#vpn" = {
          interface = "tun0";
          format = "  {essid} ({signalStrength}%)";
          format-disconnected = "⚠  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      };
  
      "hyprland/workspaces" = {
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
          format = " {icon} ";
          format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
        };
      };

      pulseaudio = {
          scroll-step = 1; # %; can be a float
          format = "{volume}% {icon}";
          format-bluetooth = " {volume}%";
          format-bluetooth-muted = " ";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
              headphone = "";
              hands-free = "וֹ";
              headset = "  ";
              phone = "";
              portable = "";
              car = "";
              default = [""];
          };
          on-click = "pavucontrol";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";
      };

      tray = {
          icon-size = 18;
          spacing = 10;
       };

      "backlight#icon" = {
          format = "{icon}";
          format-icons = [""];
          on-scroll-down = "brightnessctl -c backlight set 1%-";
          on-scroll-up = "brightnessctl -c backlight set +1%";
      };

      "backlight#value" = {
           format = "{percent}%";
           on-scroll-down = "brightnessctl -c backlight set 1%-";
           on-scroll-up = "brightnessctl -c backlight set +1%";
      };

      "custom/firefox" = {
          format = " ";
          on-click = "exec firefox";
          tooltip = false;
      };

      "custom/terminal" = {
          format = " ";
          on-click = "exec alacritty";
          tooltip = false;
      };

      "custom/files" = {
          format = " ";
          on-click = "exec thunar";
          tooltip = false;
      };

      "custom/launcher" = {
          format =" ";
          on-click = "exec wofi -c ${config.xdg.configHome}/wofi/config -I";
          tooltip = false;
      };

      "custom/power" = {
          format ="⏻";
          on-click = "exec nwg-bar";
          tooltip = false;
      };
    };

  };
}
