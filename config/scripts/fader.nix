{ pkgs }:

let
  swayfader = pkgs.callPackage ../../pkgs/swayfader {};
in 
pkgs.writeShellScriptBin "fader" ''
export SWAYFADER_CON_AC=0.9
export SWAYFADER_CON_INAC=0.6
export SWAYFADER_FADE_TIME=0.4
${swayfader}/bin/swayfader
''
