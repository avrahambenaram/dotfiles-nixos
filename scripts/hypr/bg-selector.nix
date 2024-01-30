{ config, pkgs }:

let
  bg-cava = import ./bg-cava.nix { inherit pkgs; };
  bg-pipes = import ./bg-pipes.nix { inherit pkgs; };
  bg-unimatrix = import ./bg-unimatrix.nix { inherit pkgs; };
  bg-kill = import ./bg-kill.nix { inherit pkgs; };
in
pkgs.writeShellScriptBin "bg-selector" ''

entries="Cava Pipes Unimatrix Close"

selected=$(printf '%s\n' $entries | ${pkgs.wofi}/bin/wofi --conf=${config.xdg.configHome}/wofi/config.power --style=${config.xdg.configHome}/wofi/style.widgets.css | awk '{print tolower($1)}')

case $selected in
  cava)
	alacritty --class="alacritty-bg" -e ${bg-cava}/bin/bg-cava;;
  pipes)
	alacritty --class="alacritty-bg" -e ${bg-pipes}/bin/bg-pipes;;
  unimatrix)
	alacritty --class="alacritty-bg" -e ${bg-unimatrix}/bin/bg-unimatrix;;
  close)
	pid=$(${bg-kill}/bin/bg-kill)
	kill $pid
esac

''
