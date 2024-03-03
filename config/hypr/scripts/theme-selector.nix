{ config, pkgs }:

let
  theme-switcher = import ./theme-switcher.nix { inherit config; inherit pkgs; };
in
pkgs.writeShellScriptBin "theme-selector" ''

entries="Baskerville Boxuk Catppuccin Miasma Nord Rose-Pine"

selected=$(printf '%s\n' $entries | ${pkgs.wofi}/bin/wofi --conf=${config.xdg.configHome}/wofi/config.power --style=${config.xdg.configHome}/wofi/style.widgets.css | awk '{print tolower($1)}')

case $selected in
  baskerville)
	${theme-switcher}/bin/theme-switcher baskerville;;
  boxuk)
  ${theme-switcher}/bin/theme-switcher boxuk;;
  catppuccin)
	${theme-switcher}/bin/theme-switcher catppuccin;;
  miasma)
	${theme-switcher}/bin/theme-switcher miasma;;
  nord)
	${theme-switcher}/bin/theme-switcher nord;;
  rose-pine)
	${theme-switcher}/bin/theme-switcher rose-pine;;
esac

''
