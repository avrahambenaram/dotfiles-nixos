{ config, pkgs, ... }:

{
  xdg.configFile = {
    "nwg-bar/bar.json".text = ''
      [
        {
          "label": "Lock",
          "exec": "sh ${config.xdg.configHome}/hypr/lock.sh",
          "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-lock-screen.svg"
        },
        {
          "label": "Logout",
          "exec": "hyprctl dispatch exit",
          "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-log-out.svg"
        },
        {
          "label": "Reboot",
          "exec": "systemctl reboot",
          "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-reboot.svg"
        },
        {
          "label": "Shutdown",
          "exec": "systemctl -i poweroff",
          "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-shutdown.svg"
        }
      ]
    '';

    "nwg-bar/style.css".text = ''
      window {
              background-color: rgba (0, 0, 0, 0.6);
              border-radius: 10px;
      }

      /* Outer bar container, takes all the window width/height */
      #outer-box {
          margin: 0px
      }

      /* Inner bar container, surrounds buttons */
      #inner-box {
          background-color: rgba (0, 0, 0, 0.2);
          border-radius: 10px;
          border-style: none;
          border-width: 1px;
          border-color: rgba (156, 142, 122, 0.7);
          padding: 5px;
          margin: 5px
      }

      button, image {
          background: none;
          border: none;
          box-shadow: none
      }

      button {
          padding-left: 10px;
          padding-right: 10px;
          margin: 5px;
          border-radius: 5px;
      }

      button:hover, button:focus {
          background-color: rgba (255, 255, 255, 0.1)
      }
    '';
  };
}
