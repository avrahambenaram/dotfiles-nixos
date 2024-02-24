{ pkgs }:

pkgs.writeShellScriptBin "bg-cava" ''
sleep 1 && cava
''
