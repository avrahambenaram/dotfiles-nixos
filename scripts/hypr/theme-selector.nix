{ pkgs }:

let
  theme-switcher = import ./theme-switcher.nix { inherit pkgs; };
in
pkgs.writeShellScriptBin "theme-selector" ''

entries="Baskerville Boxuk Dracula Miasma Nord Rose-Pine"

selected=$(printf '%s\n' $entries | ${pkgs.wofi}/bin/wofi --conf=$HOME/.config/wofi/config.power --style=$HOME/.config/wofi/style.widgets.css | awk '{print tolower($1)}')

case $selected in
  baskerville)
	${theme-switcher}/bin/theme-switcher baskerville;;
  boxuk)
    ${theme-switcher}/bin/theme-switcher boxuk;;
  dracula)
	${theme-switcher}/bin/theme-switcher dracula;;
  miasma)
	${theme-switcher}/bin/theme-switcher miasma;;
  nord)
	${theme-switcher}/bin/theme-switcher nord;;
  rose-pine)
	${theme-switcher}/bin/theme-switcher rose-pine;;
esac

''
