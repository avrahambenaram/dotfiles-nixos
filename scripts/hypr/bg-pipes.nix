{ pkgs }:

pkgs.writeShellScriptBin "bg-pipes" ''
sleep 1 && pipes.sh -p 20 -K -r 0
''
