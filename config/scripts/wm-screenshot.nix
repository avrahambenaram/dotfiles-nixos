{ config, pkgs }:

pkgs.writeShellScriptBin "wm-screenshot" ''

entries="Active Screen Output Area Window"

selected=$(printf '%s\n' $entries | ${pkgs.wofi}/bin/wofi --style=${config.xdg.configHome}/wofi/style.widgets.css --conf=${config.xdg.configHome}/wofi/config.screenshot | awk '{print tolower($1)}')

case $selected in
  active)
    ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save active;;
  screen)
    ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save screen;;
  output)
    ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save output;;
  area)
    ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save area;;
  window)
    ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save window;;
esac

''
