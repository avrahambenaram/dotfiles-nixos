{ pkgs }:

pkgs.writeShellScriptBin "bg-unimatrix" ''
sleep 1 && unimatrix
''
